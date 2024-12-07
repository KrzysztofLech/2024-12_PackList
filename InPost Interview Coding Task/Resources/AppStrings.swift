//  AppStrings.swift
//  Created by Krzysztof Lech on 07/12/2024.

import Foundation

enum AppStrings {
	enum Pack {
		enum Status {
			static let created = "Created"
			static let confirmed = "Confirmed"
			static let adoptedAtSourceBranch = "Adopted at source branch"
			static let sentFromSourceBranch = "Sent from source branch"
			static let adoptedAtSortingCenter = "Adopted at sorting center"
			static let sentFromSortingCenter = "Sent from sorting center"
			static let other = "Other"
			static let delivered = "Delivered"
			static let returnedToSender = "Returned to sender"
			static let avizo = "Avizo"
			static let outForDelivery = "Out for delivery"
			static let readyToPickup = "Ready to pickup"
			static let pickupTimeExpired = "Pickup time expired"
			static let unknown = "Unknown"
		}

		enum ShipmentType {
			static let parcelLocker = "Parcel locker"
			static let courier = "Courier"
			static let unknown = "Unknown"
		}
	}
}
