//
//  LandingScreenViewModel.swift
//  SwiftUIMVVMDemo
//
//  Created by Jayesh Kawli on 25/10/2022.
//

import Foundation
import Combine
import SwiftUI

class LandingScreenViewModel: ObservableObject {

    struct PostData: Identifiable {
        let id: String
        let title: String
        let body: String
    }

    struct LoadedViewModel: Equatable {

        static func == (lhs: LandingScreenViewModel.LoadedViewModel, rhs: LandingScreenViewModel.LoadedViewModel) -> Bool {
            lhs.id == rhs.id
        }

        let id: String
        let posts: [PostData]
    }

    @Published private(set) var state: LoadingState<LoadedViewModel> = .idle

    @Published var selectedPost: PostData?

    private var postsPublisher: AnyCancellable?

    @State var showErrorAlert = false

    private let networkService: NetworkServiceable

    private var postsData: [PostData] = []

    init(networkService: NetworkServiceable) {
        self.networkService = networkService
    }

    func loadData() {

        guard state != .loading else {
            return
        }

        state = .loading

        postsPublisher = networkService.getPosts().receive(on: DispatchQueue.main).sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.showErrorAlert = true
                self?.state = .failed(ErrorViewModel(message: error.localizedDescription))
            }
        } receiveValue: { [weak self] posts in

            let postsData = posts.map { PostData(id: String($0.id), title: $0.title, body: $0.body) }

            self?.postsData = postsData

            self?.state = .success(.init(id: UUID().uuidString, posts: postsData))
        }
    }

    func postSelected(at index: Int) {
        self.selectedPost = self.postsData[index]
    }
}

