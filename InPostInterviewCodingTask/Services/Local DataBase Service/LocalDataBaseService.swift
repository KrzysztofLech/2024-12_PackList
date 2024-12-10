//  LocalDataBaseService.swift
//  Created by Krzysztof Lech on 08/12/2024.

import Foundation
import RealmSwift

protocol LocalDataBaseServiceProtocol {
	func getPacks() -> [Pack]
	func savePacks(_ packs: [Pack]) throws
	func setPackAsArchived(packId: String) throws
}

final class LocalDataBaseService: LocalDataBaseServiceProtocol {

	private var realm: Realm {
		do {
			return try Realm()
		} catch {
			fatalError("Failed to initialize Realm: \(error.localizedDescription)")
		}
	}

	func getPacks() -> [Pack] {
		let realmPacks = realm.objects(PackRealmModel.self)
		return realmPacks.map(mapPackRealModelToPack)
	}

	func savePacks(_ packs: [Pack]) throws {
		try deleteAllData()

		let realmPacks = packs.map(mapPackToRealmModel)
		try realm.write {
			realm.add(realmPacks)
		}
	}

	func setPackAsArchived(packId: String) throws {
		guard let pack = realm.object(ofType: PackRealmModel.self, forPrimaryKey: packId) else { return }

		try realm.write {
			pack.archived = true
		}
	}

	private func deleteAllData() throws {
		try realm.write {
			realm.deleteAll()
		}
	}

	private func mapPackRealModelToPack(_ realmPack: PackRealmModel) -> Pack {
		Pack(
			id: realmPack.id,
			status: Status(rawValue: realmPack.status) ?? .unknown,
			sender: realmPack.sender,
			expiryDate: realmPack.expiryDate,
			pickupDate: realmPack.pickupDate,
			storedDate: realmPack.storedDate,
			shipmentType: ShipmentType(rawValue: realmPack.shipmentType) ?? .unknown,
			archived: realmPack.archived
		)
	}

	private func mapPackToRealmModel(_ pack: Pack) -> PackRealmModel {
		let realmModel = PackRealmModel()
		realmModel.id = pack.id
		realmModel.status = pack.status.rawValue
		realmModel.sender = pack.sender
		realmModel.expiryDate = pack.expiryDate
		realmModel.pickupDate = pack.pickupDate
		realmModel.storedDate = pack.storedDate
		realmModel.shipmentType = pack.shipmentType.rawValue
		realmModel.archived = pack.archived
		return realmModel
	}
}

final class PreviewLocalDataBaseService: LocalDataBaseServiceProtocol {
	func getPacks() -> [Pack] { Pack.previewData }
	func savePacks(_ packs: [Pack]) throws {}
	func setPackAsArchived(packId: String) throws {}
}
