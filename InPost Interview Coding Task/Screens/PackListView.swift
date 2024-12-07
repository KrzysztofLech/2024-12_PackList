//  PackListView.swift
//  Created by Krzysztof Lech on 07/12/2024.

import SwiftUI

struct PackListView: View {

	@ObservedObject var viewModel: PackListViewModel

    var body: some View {
		NavigationView {
			Text("Hello, World!")
				.navigationTitle(Text("Pack List"))
		}
    }
}

#Preview {
	PackListView(viewModel: PackListViewModel())
}
