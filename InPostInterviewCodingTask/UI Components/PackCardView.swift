//  PackCardView.swift
//  Created by Krzysztof Lech on 07/12/2024.

import SwiftUI

struct PackCardView: View {
	let pack: Pack
	let archiveAction: (() -> Void)?

    var body: some View {
		contentView
			.background {
				Color.packCardBackground
					.shadow(color: .shadow, radius: 10, x: 0, y: 10)
			}
			.gesture(
				LongPressGesture(minimumDuration: 0.5)
					.onEnded { _ in
						archiveAction?()
					}
			)
    }

	private var contentView: some View {
		VStack(alignment: .leading, spacing: 18) {
			packNumberView
			statusView
			senderView
		}
		.padding(.horizontal, 20)
		.padding(.vertical, 16)
	}

	private var packNumberView: some View {
		HStack(alignment: .center, spacing: 0) {

			// Left part
			VStack(alignment: .leading, spacing: 3) {
				Text(AppStrings.PackView.packNumber)
					.packCardTitleStyle()
				Text(pack.id)
					.packCardTextMediumStyle()
			}

			// Right icon if needed
			if let iconImage = pack.icon {
				Spacer(minLength: 4)
				iconImage
			}
		}
	}

	private var statusView: some View {
		HStack(alignment: .top, spacing: 0) {

			// Left part
			VStack(alignment: .leading, spacing: 3) {
				Text(AppStrings.PackView.status)
					.packCardTitleStyle()
				Text(pack.status.text)
					.packCardTextBoldStyle()
			}

			// Right part if needed
			if let date = pack.dateForDescription {
				Spacer(minLength: 32)

				VStack(alignment: .trailing, spacing: 4) {
					Text(pack.status.description)
						.packCardTitleStyle()
					dateView(date)
				}
				.layoutPriority(1)
			}
		}
	}

	private var senderView : some View {
		VStack(alignment: .leading, spacing: 3) {
			Text(AppStrings.PackView.sender)
				.packCardTitleStyle()

			HStack(alignment: .center, spacing: 0) {
				// Left text
				Text(pack.sender)
					.packCardTextBoldStyle()

				Spacer(minLength: 16)

				// Right arrow
				HStack(alignment: .center, spacing: 4) {
					Text(AppStrings.PackView.more)
						.packCardTextBoldStyle(size: 12)
					Image(.arrowRight)
				}
			}
		}
	}

	private func dateView(_ date: Date) -> some View {
		let convertedDate = date.convertedToPackCardStyle
		return HStack(alignment: .center, spacing: 0) {
			Text(convertedDate.day)
				.foregroundStyle(.textDark)
			Text(" | ")
				.foregroundStyle(.textLight)
			Text(convertedDate.date)
				.foregroundStyle(.textDark)
			Text(" | ")
				.foregroundStyle(.textLight)
			Text(convertedDate.time)
				.foregroundStyle(.textDark)
		}
		.font(.Montserrat.medium(size: 15))
	}
}

struct PackCardView_Previews: PreviewProvider {
	static var previews: some View {
		PackCardView(pack: Pack.previewData[0], archiveAction: nil)
			.previewLayout(.fixed(width: 360, height: 176))
		PackCardView(pack: Pack.previewData[1], archiveAction: nil)
			.previewLayout(.fixed(width: 360, height: 208))
	}
}
