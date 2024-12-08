//  PackListViewModel.swift
//  Created by Krzysztof Lech on 07/12/2024.

import SwiftUI

protocol PackListViewModelProtocol: ObservableObject {
	var showAlert: Bool { get set }
	var showProgressIndicator: Bool { get }
	var packGroups: [(GroupType, [Pack])] { get }

	func getData() async
	func refreshData()
	func setPackAsArchived(_ pack: Pack)
}

final class PackListViewModel: PackListViewModelProtocol {

	private let dataManager: DataManagerProtocol

	@Published var showAlert: Bool = false
	@Published private(set) var showProgressIndicator: Bool = true
	@Published private(set) var packGroups: [(GroupType, [Pack])] = []

	init(dataManager: DataManagerProtocol) {
		self.dataManager = dataManager
	}

	func getData() async -> Void {
		// Added only for demo purpose
		// to show the working of the ProgressIndicator
		try? await Task.sleep(nanoseconds: 500_000_000)

		do {
			let packs = try await dataManager.getData()
			prepareData(packs: packs)
		} catch {
			DispatchQueue.main.async { [weak self] in
				self?.showAlert = true
			}
		}
	}

	func refreshData() {
		Task { @MainActor in
			try? await Task.sleep(nanoseconds: 500_000_000)
			showProgressIndicator = true
			await getData()
		}
	}

	func setPackAsArchived(_ pack: Pack) {
		let packId = pack.id

		do {
			try dataManager.setPackAsArchived(packId: packId)

			if let groupIndex = packGroups.firstIndex(where: { $0.1.contains(where: { $0.id == packId }) }) {
				packGroups[groupIndex].1.removeAll { $0.id == packId }
				removeEmptyPackGroups()
			}
		} catch {
			DispatchQueue.main.async { [weak self] in
				self?.showAlert = true
			}
		}
	}

	private func removeEmptyPackGroups() {
		packGroups.removeAll(where: { group, packs in
			packs.isEmpty
		})
	}

	private func prepareData(packs: [Pack]) {
		let filteredPacks = packs.filter { $0.archived != true }
		let packsSorted = sortPacks(filteredPacks)

		var groups: [GroupType : [Pack]] = [:]

		// Here you can change the rules for assigning packs to the correct group
		packsSorted.forEach { pack in
			switch pack.status {
			case .outForDelivery, .readyToPickup:
				if groups[.readyToPickup] == nil {
					groups[.readyToPickup] = []
				}
				groups[.readyToPickup]?.append(pack)
			default:
				if groups[.other] == nil {
					groups[.other] = []
				}
				groups[.other]?.append(pack)
			}
		}

		DispatchQueue.main.async { [weak self] in
			self?.showProgressIndicator = false
			self?.packGroups = Array(groups.sorted {
				$0.key.rawValue < $1.key.rawValue
			})
		}
	}

	private func sortPacks(_ packs: [Pack]) -> [Pack] {
		// TODO: Add other rules
		packs
			.sorted { $0.id < $1.id }
			.sorted { $0.priority < $1.priority }
	}
}
