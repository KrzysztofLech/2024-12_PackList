//  PackListViewModel.swift
//  Created by Krzysztof Lech on 07/12/2024.

import Foundation

final class PackListViewModel: ObservableObject {
	@Published var items: [Pack] = []
}
