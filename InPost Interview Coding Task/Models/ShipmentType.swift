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
			AppStrings.Pack.ShipmentType.parcelLocker
		case .courier:
			AppStrings.Pack.ShipmentType.courier
		case .unknown:
			AppStrings.Pack.ShipmentType.unknown
		}
	}
}
