//  NetworkServiceTests.swift
//  Created by Krzysztof Lech on 09/12/2024.

import XCTest
@testable import InPostInterviewCodingTask

private final class MockURLProvider: URLProviderProtocol {
	private let mockURL: URL?

	init(mockURL: URL?) {
		self.mockURL = mockURL
	}

	func getURL() -> URL? {
		return mockURL
	}
}

private final class NetworkServiceTests: XCTestCase {

	private var jsonDecoder: JSONDecoder!
	private let validJSON: Data = """
	[
		{
			"id": "46730345345597442248333",
			"status": "OUT_FOR_DELIVERY",
			"sender": "Pan Tadeusz",
			"expiryDate": "2022-12-05T04:56:07Z",
			"storedDate": "2022-11-25T04:56:07Z",
			"shipmentType": "COURIER"
		}
	]
	""".data(using: .utf8)!


	override func setUp() {
		super.setUp()
		jsonDecoder = JSONDecoder()
		jsonDecoder.dateDecodingStrategy = .iso8601
	}

	override func tearDown() {
		super.tearDown()
	}

	func testGetPacksReturnsPacksWhenDataIsValid() async throws {
		let tempURL = createTemporaryFile(with: validJSON)
		let urlProvider = MockURLProvider(mockURL: tempURL)
		let sut = NetworkService(urlProvider: urlProvider, jsonDecoder: jsonDecoder)

		let packs = try await sut.getPacks()

		XCTAssertEqual(packs.count, 1)
		XCTAssertEqual(packs.first?.id, "46730345345597442248333")
		XCTAssertEqual(packs.first?.sender, "Pan Tadeusz")
	}

	func testGetPacksThrowsDataNotFoundWhenFileIsEmpty() async throws {
		let tempURL = createTemporaryFile(with: Data())
		let urlProvider = MockURLProvider(mockURL: tempURL)
		let sut = NetworkService(urlProvider: urlProvider, jsonDecoder: jsonDecoder)

		do {
			_ = try await sut.getPacks()
			XCTFail("Expected error not thrown")
		} catch let error as NetworkingError {
			XCTAssertEqual(error, .dataNotFound)
		} catch {
			XCTFail("Unexpected error: \(error)")
		}
	}

	func testGetPacksThrowsInvalidURLWhenURLIsNil() async throws {
		let urlProvider = MockURLProvider(mockURL: nil)
		let sut = NetworkService(urlProvider: urlProvider, jsonDecoder: jsonDecoder)

		do {
			_ = try await sut.getPacks()
			XCTFail("Expected error not thrown")
		} catch let error as NetworkingError {
			XCTAssertEqual(error, .invalidURL)
		} catch {
			XCTFail("Unexpected error: \(error)")
		}
	}

	private func createTemporaryFile(with data: Data) -> URL {
		let tempDirectory = FileManager.default.temporaryDirectory
		let tempFileURL = tempDirectory.appendingPathComponent(UUID().uuidString)
		try? data.write(to: tempFileURL)
		return tempFileURL
	}
}
