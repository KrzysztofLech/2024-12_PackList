//  NetworkService.swift
//  Created by Krzysztof Lech on 08/12/2024.

import Foundation

protocol URLProviderProtocol {
	func getURL() -> URL?
}

final class DefaultURLProvider: URLProviderProtocol {
	func getURL() -> URL? {
		return Bundle.main.url(forResource: "packs", withExtension: "json")
	}
}

protocol NetworkServiceProtocol {
	func getPacks() async throws -> [Pack]	// 'async' will be needed for API requests
}

final class NetworkService: NetworkServiceProtocol {

	private let urlProvider: URLProviderProtocol
	private let jsonDecoder: JSONDecoder

	init(urlProvider: URLProviderProtocol = DefaultURLProvider(),
		 jsonDecoder: JSONDecoder = JSONDecoder()) {
		self.urlProvider = urlProvider
		self.jsonDecoder = jsonDecoder
		self.jsonDecoder.dateDecodingStrategy = .iso8601
	}

	func getPacks() async throws -> [Pack] {
		guard let url = urlProvider.getURL() else {
			throw NetworkingError.invalidURL
		}

		guard let data = try? Data(contentsOf: url), !data.isEmpty else {
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

final class PreviewNetworkService: NetworkServiceProtocol {
	func getPacks() async throws -> [Pack] { Pack.previewData }
}
