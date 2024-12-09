//  TextViewModifiers.swift
//  Created by Krzysztof Lech on 07/12/2024.

import SwiftUI

struct PackCardTitleModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.Montserrat.semiBold(size: 11))
			.foregroundStyle(.textLight)
	}
}

struct PackCardTextMediumModifier: ViewModifier {
	let size: CGFloat

	func body(content: Content) -> some View {
		content
			.font(.Montserrat.medium(size: size))
			.foregroundStyle(.textDark)
	}
}

struct PackCardTextBoldModifier: ViewModifier {
	let size: CGFloat

	func body(content: Content) -> some View {
		content
			.font(.Montserrat.bold(size: size))
			.foregroundStyle(.textDark)
	}
}

extension View {
	func packCardTitleStyle() -> some View {
		self.modifier(PackCardTitleModifier())
	}

	func packCardTextMediumStyle(size: CGFloat = 15) -> some View {
		self.modifier(PackCardTextMediumModifier(size: size))
	}

	func packCardTextBoldStyle(size: CGFloat = 15) -> some View {
		self.modifier(PackCardTextBoldModifier(size: size))
	}
}
