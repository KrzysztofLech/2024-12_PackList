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
        buildStartingView()
        return true
    }

    private func buildStartingView() {
		let packListViewModel = PackListViewModel()
		let packListView = PackListView(viewModel: packListViewModel)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIHostingController(rootView: packListView)
        window?.makeKeyAndVisible()
    }
}
