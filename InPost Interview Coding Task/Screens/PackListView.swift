//  PackListView.swift
//  Created by Krzysztof Lech on 07/12/2024.

import SwiftUI

struct PackListView: View {

	@ObservedObject var viewModel: PackListViewModel

    var body: some View {
		NavigationView {
			List {
				Text("Hello, World!")
					.font(.Montserrat.medium(size: 20))
				Text("Hello, World!")
					.font(.Montserrat.semiBold(size: 20))
				Text("Hello, World!")
					.font(.Montserrat.bold(size: 20))
				Text("Hello, World!")
					.font(.Montserrat.extraBold(size: 20))
				Text("Hello, World!")
					.font(.Montserrat.black(size: 20))

			}
			.navigationTitle(Text("Pack List"))
		}
    }
}

#Preview {
	PackListView(viewModel: PackListViewModel())
}
