//  Status.swift
//  Created by Krzysztof Lech on 07/12/2024.

enum Status: String, Decodable {
	case created = "CREATED"
	case confirmed = "CONFIRMED"
	case adoptedAtSourceBranch = "ADOPTED_AT_SOURCE_BRANCH"
	case sentFromSourceBranch = "SENT_FROM_SOURCE_BRANCH"
	case adoptedAtSortingCenter = "ADOPTED_AT_SORTING_CENTER"
	case sentFromSortingCenter = "SENT_FROM_SORTING_CENTER"
	case other = "OTHER"
	case delivered = "DELIVERED"
	case returnedToSender = "RETURNED_TO_SENDER"
	case avizo = "AVIZO"
	case outForDelivery = "OUT_FOR_DELIVERY"
	case readyToPickup = "READY_TO_PICKUP"
	case pickupTimeExpired = "PICKUP_TIME_EXPIRED"
	case unknown

	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try? container.decode(String.self)
		self = Status(rawValue: rawValue ?? "") ?? .unknown
	}
}

extension Status {
	var text: String {
		switch self {
		case .created:
			AppStrings.Pack.Status.created
		case .confirmed:
			AppStrings.Pack.Status.confirmed
		case .adoptedAtSourceBranch:
			AppStrings.Pack.Status.adoptedAtSourceBranch
		case .sentFromSourceBranch:
			AppStrings.Pack.Status.sentFromSourceBranch
		case .adoptedAtSortingCenter:
			AppStrings.Pack.Status.adoptedAtSortingCenter
		case .sentFromSortingCenter:
			AppStrings.Pack.Status.sentFromSortingCenter
		case .other:
			AppStrings.Pack.Status.other
		case .delivered:
			AppStrings.Pack.Status.delivered
		case .returnedToSender:
			AppStrings.Pack.Status.returnedToSender
		case .avizo:
			AppStrings.Pack.Status.avizo
		case .outForDelivery:
			AppStrings.Pack.Status.outForDelivery
		case .readyToPickup:
			AppStrings.Pack.Status.readyToPickup
		case .pickupTimeExpired:
			AppStrings.Pack.Status.pickupTimeExpired
		case .unknown:
			AppStrings.Pack.Status.unknown
		}
	}
}
