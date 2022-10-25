//
//  NetworkService.swift
//  SwiftUIMVVMDemo
//
//  Created by Jayesh Kawli on 25/10/2022.
//

import Foundation
import Combine

protocol NetworkServiceable {
    func getPosts() -> AnyPublisher<[Post], Never>
}

class NetworkService: NetworkServiceable {

    let urlSession: URLSession
    let baseURLString: String

    init(urlSession: URLSession = .shared, baseURLString: String) {
        self.urlSession = urlSession
        self.baseURLString = baseURLString
    }

    func getPosts() -> AnyPublisher<[Post], Never> {

        let urlString = baseURLString + "posts"

        guard let url = URL(string: urlString) else {
            return Just<[Post]>([]).eraseToAnyPublisher()
        }

        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
