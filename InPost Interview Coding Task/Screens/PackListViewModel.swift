//  PackListViewModel.swift
//  Created by Krzysztof Lech on 07/12/2024.

import Foundation

protocol PackListViewModelProtocol: ObservableObject {
	var packGroups: [(GroupType, [Pack])] { get }
	var showAlert: Bool { get set }
	func getData() async
	func refreshData()
}

final class PackListViewModel: PackListViewModelProtocol {

	private let dataManager: DataManagerProtocol

	@Published var packGroups: [(GroupType, [Pack])] = []
	@Published var showAlert: Bool = false

	init(dataManager: DataManagerProtocol) {
		self.dataManager = dataManager
	}

	func getData() async -> Void {
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
		print("❤️")
	}

	private func prepareData(packs: [Pack]) {
		let packsSorted = sortPacks(packs)

		var groups: [GroupType : [Pack]] = [:]
		groups[.readyToPickup] = []
		groups[.other] = []

		/// Here you can change the rules for assigning packs to the correct group
		packsSorted.forEach { pack in
			switch pack.status {
			case .outForDelivery, .readyToPickup:
				groups[.readyToPickup]?.append(pack)
			default:
				groups[.other]?.append(pack)
			}
		}

		DispatchQueue.main.async { [weak self] in
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
