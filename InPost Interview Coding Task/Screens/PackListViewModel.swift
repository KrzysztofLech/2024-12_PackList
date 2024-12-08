//  PackListViewModel.swift
//  Created by Krzysztof Lech on 07/12/2024.

import Foundation

final class PackListViewModel: ObservableObject {

	@Published var packGroups: [(GroupType, [Pack])] = []

	func getData() {
		let packs = Pack.previewData

		// TODO: add sorting

		var groups: [GroupType : [Pack]] = [:]
		groups[.readyToPickup] = []
		groups[.other] = []

		/// Here you can change the rules for assigning packs to the correct group
		packs.forEach { pack in
			switch pack.status {
			case .outForDelivery, .readyToPickup:
				groups[.readyToPickup]?.append(pack)
			default:
				groups[.other]?.append(pack)
			}
		}

		packGroups = Array(groups.sorted {
			$0.key.rawValue < $1.key.rawValue
		})
	}

	func refreshData() {
		print("❤️")
	}
}
