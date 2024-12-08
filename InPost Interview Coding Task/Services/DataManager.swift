//  DataManager.swift
//  Created by Krzysztof Lech on 08/12/2024.

import Foundation

protocol DataManagerProtocol {
	func getData() async throws -> [Pack]
}

final class DataManager: DataManagerProtocol {

	private let networkService: NetworkServiceProtocol

	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService
	}

	func getData() async throws -> [Pack] {
		try await networkService.getPacks()
	}
}
