//
//  Combine+Async.swift
//  Requests
//
//  Created by Evgenii Kononenko on 17.03.25.
//

import Foundation
import Combine

extension Future where Failure == Error {
    convenience init(priority: TaskPriority? = nil, operation: @escaping () async throws -> Output) {
        self.init { promise in
            Task(priority: priority) {
                do {
                    let output = try await operation()
                    promise(.success(output))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }

    convenience init(priority: TaskPriority? = nil, operation: @escaping () async -> Output) {
        self.init { promise in
            Task(priority: priority) {
                let output = await operation()
                promise(.success(output))
            }
        }
    }
}
