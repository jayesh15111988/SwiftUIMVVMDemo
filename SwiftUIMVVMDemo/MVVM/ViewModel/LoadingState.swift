//
//  LoadingState.swift
//  SwiftUIMVVMDemo
//
//  Created by Jayesh Kawli on 25/10/2022.
//

import Foundation

struct ErrorViewModel: Equatable {
    let message: String
}

enum LoadingState<LoadedViewModel: Equatable>: Equatable {
    case idle
    case loading
    case failed(ErrorViewModel)
    case success(LoadedViewModel)
}

