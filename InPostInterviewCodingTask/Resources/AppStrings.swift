//  AppStrings.swift
//  Created by Krzysztof Lech on 07/12/2024.

import Foundation

/// In a multilingual application, strings will be replaced by localization keys
enum AppStrings {
	enum PackDataModel {
		enum Status {
			static let created = "Utworzona"
			static let confirmed = "Potwierdzona"
			static let adoptedAtSourceBranch = "Przyjęta w oddziale"
			static let sentFromSourceBranch = "Wysłana z oddziału"
			static let adoptedAtSortingCenter = "Przyjęta w centrum sortowania"
			static let sentFromSortingCenter = "Wysłana z centrum sortowania"
			static let other = "Inny"
			static let delivered = "Odebrana"
			static let returnedToSender = "Zwrócona do nadawcy"
			static let avizo = "Zostawiono awizo"
			static let outForDelivery = "Wydana do doręczenia"
			static let readyToPickup = "Gotowa do odbioru"
			static let pickupTimeExpired = "Minął czas odbioru"
			static let unknown = "Nieznany"
		}

		enum StatusDescription {
			static let confirmed = "POTWIERDZONA"
			static let delivered = "ODEBRANA"
			static let readyToPickup = "CZEKA NA ODBIÓR DO"
		}

		enum ShipmentType {
			static let parcelLocker = "Paczkomat"
			static let courier = "Kurier"
			static let unknown = "Nieznany"
		}
	}

	enum ListView {
		static let title = "InPost recruitment task"
		static let noPacks = "Nie masz\nprzesyłek"

		enum Group {
			static let readyToPickup = "Gotowe do odbioru"
			static let other = "Pozostałe"
		}
	}

	enum PackView {
		static let packNumber = "NR PRZESYŁKI"
		static let status = "STATUS"
		static let sender = "NADAWCA"
		static let more = "więcej"
	}

	enum Group {
		static let readyToPickup = "Gotowe do odbioru"
		static let other = "Pozostałe"
	}

	enum Error {
		static let title = "Error!"
		static let message = "Some problems have occurred 😔"
		static let buttonTitle = "OK"
	}
}
