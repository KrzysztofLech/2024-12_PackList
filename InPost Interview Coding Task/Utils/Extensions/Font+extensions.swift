//  Font+extensions.swift
//  Created by Krzysztof Lech on 07/12/2024.

import SwiftUI

extension Font {
	enum Montserrat {
		static func medium(size: CGFloat) -> Font {
			.custom("Montserrat-Medium", size: size)
		}

		static func semiBold(size: CGFloat) -> Font {
			.custom("Montserrat-SemiBold", size: size)
		}

		static func bold(size: CGFloat) -> Font {
			.custom("Montserrat-Bold", size: size)
		}

		static func extraBold(size: CGFloat) -> Font {
			.custom("Montserrat-ExtraBold", size: size)
		}

		static func black(size: CGFloat) -> Font {
			.custom("Montserrat-Black", size: size)
		}
	}
}
