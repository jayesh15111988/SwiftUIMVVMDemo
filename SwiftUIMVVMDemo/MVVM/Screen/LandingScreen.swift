//
//  LandingScreen.swift
//  SwiftUIMVVMDemo
//
//  Created by Jayesh Kawli on 25/10/2022.
//

import SwiftUI

struct LandingScreen: View {

    @ObservedObject var viewModel: LandingScreenViewModel

    var body: some View {
        let state = viewModel.state

        switch state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.loadData)
        case .loading:
            ProgressView()
        case .success(let loadedViewModel):
            VStack(alignment: .leading) {
                List {
                    ForEach(loadedViewModel.posts.indices, id: \.self) { index in

                        let post = loadedViewModel.posts[index]

                        VStack(alignment: .leading, spacing: 12) {
                            Text(post.title)
                                .font(.title)
                                .fontWeight(.bold)
                            Text(post.body)
                                .font(.body)
                                .fontWeight(.medium)
                        }.onTapGesture {
                            viewModel.postSelected(at: index)
                        }
                    }
                }
            }
            .sheet(item: $viewModel.selectedPost) { selectedPost in
                Text(selectedPost.title)
            }
        case .failed(let errorViewModel):
            Color.clear.alert(isPresented: $viewModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorViewModel.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
