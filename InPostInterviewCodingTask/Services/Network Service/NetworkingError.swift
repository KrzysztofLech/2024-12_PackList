//  NetworkingError.swift
//  Created by Krzysztof Lech on 08/12/2024.

import Foundation

enum NetworkingError: LocalizedError {
	case dataNotFound
	case invalidURL
	case invalidRequest
	case invalidResponse
	case parseJSON(DecodingError)
	case api(statusCode: Int, message: String?)
	case unknown(Error)

	var errorDescription: String {
		switch self {
		case .dataNotFound:
			return "Data not found!"

		case .invalidURL:
			return "Invalid URL"

		case .invalidRequest:
			return "Invalid Request"

		case .invalidResponse:
			return "Invalid Response"

		case let .parseJSON(error):
			var errorContext: DecodingError.Context?
			switch error {
			case .dataCorrupted(let context):
				errorContext = context
			case .keyNotFound(_, let context):
				errorContext = context
			case .typeMismatch(_, let context):
				errorContext = context
			case .valueNotFound(_, let context):
				errorContext = context
			default: ()
			}

			guard let errorContext else { return "Data parsing error!" }

			let codingPath = String(describing: errorContext.codingPath)
			let debugDescription = String(describing: errorContext.debugDescription)
			return "Data parsing error!\ncodingPath: \(codingPath)\ndescription \(debugDescription)"

		case let .api(statusCode, message):
			guard let message = message, !message.isEmpty else {
				return "API problem, status code: \(statusCode)"
			}
			return "\(message), status code: \(statusCode)"

		case let .unknown(error):
			return error.localizedDescription
		}
	}
}
