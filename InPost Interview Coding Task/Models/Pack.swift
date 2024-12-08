//
//  Pack.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import SwiftUI

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

struct Pack: Decodable, Identifiable {
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

	var icon: Image? {
		switch status {
		case .outForDelivery:
			Image(.kurier)
		case .readyToPickup, .delivered:
			Image(.paczkomat)
		default:
			nil
		}
	}

	/// For the purposes of the Interview Coding Task, only a few statuses have a defined date
	var dateForDescription: Date? {
		switch self.status {
		case .confirmed:
			storedDate
		case .delivered:
			pickupDate
		case .readyToPickup:
			expiryDate
		default:
			nil
		}
	}
}

extension Pack {
	static var previewData: [Pack] = [
		.init(
			id: "235678654323567889762231",
			status: .outForDelivery,
			sender: "adresmailowy@mail.pl",
			expiryDate: nil,
			pickupDate: nil,
			storedDate: nil,
			shipmentType: .parcelLocker
		),
		.init(
			id: "235678654323567889762232",
			status: .readyToPickup,
			sender: "adresmailowy@mail.pl",
			expiryDate: .now,
			pickupDate: nil,
			storedDate: nil,
			shipmentType: .parcelLocker
		),
		.init(
			id: "96730345345597442248333",
			status: .delivered,
			sender: "Adam Bielak",
			expiryDate: nil,
			pickupDate: Date.now.addingTimeInterval(-86400),
			storedDate: nil,
			shipmentType: .parcelLocker
		),
		.init(
			id: "96730345345597442248334",
			status: .unknown,
			sender: "Nieznany",
			expiryDate: nil,
			pickupDate: nil,
			storedDate: nil,
			shipmentType: .courier
		)
	]
}
