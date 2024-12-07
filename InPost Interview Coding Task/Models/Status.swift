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
			AppStrings.PackDataModel.Status.created
		case .confirmed:
			AppStrings.PackDataModel.Status.confirmed
		case .adoptedAtSourceBranch:
			AppStrings.PackDataModel.Status.adoptedAtSourceBranch
		case .sentFromSourceBranch:
			AppStrings.PackDataModel.Status.sentFromSourceBranch
		case .adoptedAtSortingCenter:
			AppStrings.PackDataModel.Status.adoptedAtSortingCenter
		case .sentFromSortingCenter:
			AppStrings.PackDataModel.Status.sentFromSortingCenter
		case .other:
			AppStrings.PackDataModel.Status.other
		case .delivered:
			AppStrings.PackDataModel.Status.delivered
		case .returnedToSender:
			AppStrings.PackDataModel.Status.returnedToSender
		case .avizo:
			AppStrings.PackDataModel.Status.avizo
		case .outForDelivery:
			AppStrings.PackDataModel.Status.outForDelivery
		case .readyToPickup:
			AppStrings.PackDataModel.Status.readyToPickup
		case .pickupTimeExpired:
			AppStrings.PackDataModel.Status.pickupTimeExpired
		case .unknown:
			AppStrings.PackDataModel.Status.unknown
		}
	}

	/// For the purposes of the Interview Coding Task, only a few statuses have a description
	var description: String {
		switch self {
		case .confirmed:
			AppStrings.PackDataModel.StatusDescription.confirmed
		case .delivered:
			AppStrings.PackDataModel.StatusDescription.delivered
		case .readyToPickup:
			AppStrings.PackDataModel.StatusDescription.readyToPickup
		default:
			""
		}
	}
}
