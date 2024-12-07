//  PackListView.swift
//  Created by Krzysztof Lech on 07/12/2024.

import SwiftUI

struct PackListView: View {

	@ObservedObject var viewModel: PackListViewModel

	var body: some View {
		NavigationView {
			ScrollView(.vertical, showsIndicators: false) {
				VStack(spacing: 15) {
					ForEach(viewModel.packs) { pack in
						PackCardView(pack: pack)
					}
				}
			}
			.background{
				Color.background.ignoresSafeArea()
			}

			// Navigation bar
			.navigationTitle("")
			.toolbar {
				ToolbarItem(placement: .navigation) {
					Text(AppStrings.ListView.title)
						.font(.Montserrat.bold(size: 15))
						.foregroundColor(.textDark)
						.padding([.leading, .bottom], 4)
				}
			}

			// Refresh data
			.refreshable {
				viewModel.refreshData()
			}
		}
	}

}

#Preview {
	PackListView(viewModel: PackListViewModel())
}
