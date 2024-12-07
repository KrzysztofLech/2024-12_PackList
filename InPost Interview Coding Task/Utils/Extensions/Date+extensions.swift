//  Date+extensions.swift
//  Created by Krzysztof Lech on 07/12/2024.

import Foundation

extension Date {
	var convertedToPackCardStyle: (day: String, date: String, time: String) {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "pl_PL") // Should be modified for other language

		dateFormatter.dateFormat = "E"
		let dayName = dateFormatter.string(from: self)

		dateFormatter.dateFormat = "dd.MM.yy"
		let dateString = dateFormatter.string(from: self)

		dateFormatter.dateFormat = "HH:mm"
		let timeString = dateFormatter.string(from: self)
		
		return (dayName, dateString, timeString)
	}
}
