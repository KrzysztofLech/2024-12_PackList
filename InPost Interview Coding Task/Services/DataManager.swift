//  DataManager.swift
//  Created by Krzysztof Lech on 08/12/2024.

import Foundation

protocol DataManagerProtocol {
	func getData() async throws -> [Pack]
	func setPackAsArchived(packId: String) throws
}

final class DataManager: DataManagerProtocol {

	private let localDataBaseService: LocalDataBaseServiceProtocol
	private let networkService: NetworkServiceProtocol

	init(localDataBaseService: LocalDataBaseServiceProtocol, networkService: NetworkServiceProtocol) {
		self.localDataBaseService = localDataBaseService
		self.networkService = networkService
	}

	func getData() async throws -> [Pack] {
		let storedPacks = localDataBaseService.getPacks()
		var packs = try await networkService.getPacks()

		storedPacks.forEach { storedPack in
			if storedPack.archived == true,
			   let index = packs.firstIndex(where: { $0.id == storedPack.id }) {
				packs[index].archived = true
			}
		}

		try localDataBaseService.savePacks(packs)

		return packs
	}

	func setPackAsArchived(packId: String) throws {
		try localDataBaseService.setPackAsArchived(packId: packId)
	}
}
