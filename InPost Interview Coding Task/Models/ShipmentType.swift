//  ShipmentType.swift
//  Created by Krzysztof Lech on 07/12/2024.

/**
 * List of possible shipmentType.
 * 1. PARCEL_LOCKER
 * 2. COURIER
 */

enum ShipmentType: String, Decodable {
	case parcelLocker = "PARCEL_LOCKER"
	case courier = "COURIER"
	case unknown

	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try? container.decode(String.self)
		self = ShipmentType(rawValue: rawValue ?? "") ?? .unknown
	}
}

extension ShipmentType {
	var text: String {
		switch self {
		case .parcelLocker:
			AppStrings.PackDataModel.ShipmentType.parcelLocker
		case .courier:
			AppStrings.PackDataModel.ShipmentType.courier
		case .unknown:
			AppStrings.PackDataModel.ShipmentType.unknown
		}
	}
}
