//  PackListView.swift
//  Created by Krzysztof Lech on 07/12/2024.

import SwiftUI

struct PackListView: View {

	@ObservedObject var viewModel: PackListViewModel

    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
	PackListView(viewModel: PackListViewModel())
}
