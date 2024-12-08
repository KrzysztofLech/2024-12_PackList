//  PackListViewModel.swift
//  Created by Krzysztof Lech on 07/12/2024.

import SwiftUI

protocol PackListViewModelProtocol: ObservableObject {
	var showAlert: Bool { get set }
	var showProgressIndicator: Bool { get }
	var packGroups: [(GroupType, [Pack])] { get }

	func getData() async
	func refreshData()
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

	private func prepareData(packs: [Pack]) {
		let packsSorted = sortPacks(packs)

		var groups: [GroupType : [Pack]] = [:]
		groups[.readyToPickup] = []
		groups[.other] = []

		// Here you can change the rules for assigning packs to the correct group
		packsSorted.forEach { pack in
			switch pack.status {
			case .outForDelivery, .readyToPickup:
				groups[.readyToPickup]?.append(pack)
			default:
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
		packs
			.sorted { $0.priority < $1.priority }

		//// Add other rules
		// TODO: Add other rules
	}
}
