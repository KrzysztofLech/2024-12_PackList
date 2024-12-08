//  LocalDataBaseService.swift
//  Created by Krzysztof Lech on 08/12/2024.

//import Foundation
import RealmSwift

protocol LocalDataBaseServiceProtocol {
	func getPacks() throws -> [Pack]
	func savePacks(_ packs: [Pack]) throws
	func setPackAsArchived(packId: String) throws
}

final class LocalDataBaseService: LocalDataBaseServiceProtocol {

	func getPacks() throws -> [Pack] {
		do {
			let realm = try Realm()
			let realmPacks = realm.objects(PackRealmModel.self)
			return realmPacks.map(mapPackRealModelToPack)
		} catch {
			throw error
		}
	}

	func savePacks(_ packs: [Pack]) throws {
		try deleteAllPacks()

		do {
			let realm = try Realm()
			let realmPacks = packs.map(mapPackToRealmModel)
			try realm.write {
				realm.add(realmPacks)
			}
		} catch {
			throw error
		}
	}

	func setPackAsArchived(packId: String) throws {
		do {
			let realm = try Realm()
			if let pack = realm.object(ofType: PackRealmModel.self, forPrimaryKey: packId) {
				try realm.write {
					pack.archived = true
				}
			}
		} catch {
			throw error
		}
	}

	private func deleteAllPacks() throws {
		do {
			let realm = try Realm()
			try realm.write {
				realm.deleteAll()
			}
		} catch {
			throw error
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
