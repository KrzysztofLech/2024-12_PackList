//  PackListView.swift
//  Created by Krzysztof Lech on 07/12/2024.

import SwiftUI

struct PackListView<ViewModel: PackListViewModelProtocol>: View {

	@ObservedObject var viewModel: ViewModel

	var body: some View {
		NavigationView {
			contentView
				.navigationTitle("")
				.toolbar { // Custom Navigation Bar
					ToolbarItem(placement: .navigation) {
						Text(AppStrings.ListView.title)
							.font(.Montserrat.bold(size: 15))
							.foregroundColor(.textDark)
							.padding([.leading, .bottom], 4)
					}
				}
		}

		.task {
			await viewModel.getData()
		}

		.refreshable {
			viewModel.refreshData()
		}

		.alert(isPresented: $viewModel.showAlert) {
			Alert(title: Text(AppStrings.Error.title),
				  message: Text(AppStrings.Error.message),
				  dismissButton: .default(Text(AppStrings.Error.buttonTitle)))
		}
	}

	@ViewBuilder
	private var contentView: some View {
		ZStack {
			packListView
			if viewModel.showProgressIndicator {
				progressIndicatorView
			}
		}
	}

	private var packListView: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(spacing: 0) {
				ForEach(viewModel.packGroups, id: \.0) { groupStyle, packs in
					VStack(spacing: 0) {
						GroupHeaderView(style: groupStyle)
						VStack(spacing: 15) {
							ForEach(packs) { pack in
								PackCardView(pack: pack)
							}
						}
					}
				}
			}
		}
		.background{
			Color.background.ignoresSafeArea()
		}
	}

	private var progressIndicatorView: some View {
		ZStack {
			Color.background
				.opacity(0.7)
				.ignoresSafeArea()
			ProgressView()
				.scaleEffect(2)
				.tint(.accentColor)
		}
	}
}

#Preview {
	PackListView(
		viewModel: PackListViewModel(
			dataManager: DataManager(
				//networkService: MockNetworkService()
				networkService: NetworkService()
			)
		)
	)
}
