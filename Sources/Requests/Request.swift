//
//  Request.swift
//  Requests
//
//  Created by Evgenii Kononenko on 16.03.25.
//

import Combine

public protocol Request<Output> {
    associatedtype Output
    func fetch() async throws -> Output
    func fetchPublisher() -> AnyPublisher<Output, Error>
}

public extension Request {
    func fetchPublisher() -> AnyPublisher<Output, Error> {
        Future {
            try await fetch()
        }
        .eraseToAnyPublisher()
    }
}
