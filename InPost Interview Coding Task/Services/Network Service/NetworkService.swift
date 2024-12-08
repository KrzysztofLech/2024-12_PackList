//  NetworkService.swift
//  Created by Krzysztof Lech on 08/12/2024.

import Foundation

protocol NetworkServiceProtocol {
	func getPacks() async throws -> [Pack]
}

final class NetworkService: NetworkServiceProtocol {

	private let url = Bundle.main.url(forResource: "packs", withExtension: "json")!

    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

	func getPacks() async throws -> [Pack] {
		guard let data = try? Data(contentsOf: url) else {
			throw NetworkingError.dataNotFound
		}

		do {
			return try jsonDecoder.decode([Pack].self, from: data)
		} catch {
			if let decodingError = error as? DecodingError {
				throw NetworkingError.parseJSON(decodingError)
			}
			throw NetworkingError.unknown(error)
		}
	}
}

final class MockNetworkService: NetworkServiceProtocol {
	func getPacks() async throws -> [Pack] {
		Pack.previewData
	}
}