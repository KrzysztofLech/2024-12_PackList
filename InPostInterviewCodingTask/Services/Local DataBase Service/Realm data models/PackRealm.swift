//  PackRealm.swift
//  Created by Krzysztof Lech on 08/12/2024.

import Foundation
import RealmSwift

final class PackRealmModel: Object {
	@Persisted(primaryKey: true) var id: String
	@Persisted var status: String
	@Persisted var sender: String
	@Persisted var expiryDate: Date?
	@Persisted var pickupDate: Date?
	@Persisted var storedDate: Date?
	@Persisted var shipmentType: String
	@Persisted var archived: Bool?
}
