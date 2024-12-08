//
//  AppDelegate.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		setupNavigationBarAppearance()
        buildStartingView()
        return true
    }

    private func buildStartingView() {
		let localDataBaseService: LocalDataBaseServiceProtocol = LocalDataBaseService()
		let networkService: NetworkServiceProtocol = NetworkService()
		let dataManager: DataManagerProtocol = DataManager(
			localDataBaseService: localDataBaseService,
			networkService: networkService
		)

		let packListViewModel = PackListViewModel(dataManager: dataManager)
		let packListView = PackListView(viewModel: packListViewModel)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIHostingController(rootView: packListView)
        window?.makeKeyAndVisible()
    }

	private func setupNavigationBarAppearance() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = UIColor.systemBackground

		UINavigationBar.appearance().standardAppearance = appearance
		UINavigationBar.appearance().scrollEdgeAppearance = appearance
	}
}
