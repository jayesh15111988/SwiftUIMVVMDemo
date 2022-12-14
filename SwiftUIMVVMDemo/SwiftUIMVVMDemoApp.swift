//
//  SwiftUIMVVMDemoApp.swift
//  SwiftUIMVVMDemo
//
//  Created by Jayesh Kawli on 25/10/2022.
//

import SwiftUI

@main
struct SwiftUIMVVMDemoApp: App {
    var body: some Scene {
        WindowGroup {
            let networkService = NetworkService(baseURLString: "https://jsonplaceholder.typicode.com/")
            let viewModel = LandingScreenViewModel(networkService: networkService)
            LandingScreen(viewModel: viewModel)
        }
    }
}
