//
//  Pack.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import Foundation

/**
 * List of possible statuses with priority order.
 * 1. CREATED
 * 2. CONFIRMED
 * 3. ADOPTED_AT_SOURCE_BRANCH
 * 4. SENT_FROM_SOURCE_BRANCH
 * 5. ADOPTED_AT_SORTING_CENTER
 * 6. SENT_FROM_SORTING_CENTER
 * 7. OTHER
 * 8. DELIVERED
 * 9. RETURNED_TO_SENDER
 * 10. AVIZO
 * 11. OUT_FOR_DELIVERY
 * 12. READY_TO_PICKUP
 * 13. PICKUP_TIME_EXPIRED
 */

struct Pack: Decodable {
    let id: String
	let status: Status
    let sender: String
    let expiryDate: Date?
    let pickupDate: Date?
    let storedDate: Date?
    let shipmentType: ShipmentType
}

extension Pack {
	var priority: Int {
		switch status {
		case .created:
			1
		case .confirmed:
			2
		case .adoptedAtSourceBranch:
			3
		case .sentFromSourceBranch:
			4
		case .adoptedAtSortingCenter:
			5
		case .sentFromSortingCenter:
			6
		case .other:
			7
		case .delivered:
			8
		case .returnedToSender:
			9
		case .avizo:
			10
		case .outForDelivery:
			11
		case .readyToPickup:
			12
		case .pickupTimeExpired:
			13
		case .unknown:
			14
		}
	}
}