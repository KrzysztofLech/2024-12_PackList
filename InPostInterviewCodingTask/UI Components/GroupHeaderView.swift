//  GroupHeaderView.swift
//  Created by Krzysztof Lech on 07/12/2024.

import SwiftUI

/// Defines the available groups of packs and makes it easy to add more
enum GroupType: Int {
	case readyToPickup, other

	var title: String {
		switch self {
		case .readyToPickup:
			AppStrings.Group.readyToPickup
		case .other:
			AppStrings.Group.other
		}
	}
}

struct GroupHeaderView: View {

	let style: GroupType

    var body: some View {
		HStack(alignment: .center, spacing: 16) {
			horizontalLineView
			titleView
			horizontalLineView
		}
		.padding(.horizontal, 20)
		.frame(height: 48)
    }

	private var horizontalLineView: some View {
		Rectangle()
			.fill(.groupSeparator)
			.frame(height: 1)
	}

	private var titleView: some View {
		Text(style.title)
			.lineLimit(1)
			.font(.Montserrat.semiBold(size: 13))
			.foregroundStyle(.groupTitle)
			.layoutPriority(1)
	}
}

struct GroupHeaderView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			GroupHeaderView(style: .readyToPickup)
			GroupHeaderView(style: .other)
		}
		.previewLayout(.fixed(width: 360, height: 48))
	}
}
