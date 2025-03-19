//
//  JSONDataRequest.swift
//  Requests
//
//  Created by Evgenii Kononenko on 16.03.25.
//

import Foundation

public protocol JSONDataDecoding: DataDecoding { }

extension JSONDataDecoding where Output: Decodable {
    public func decode(_ data: Data) throws -> Output {
        return try JSONDecoder.requestJsonDecoder
            .decode(Output.self, from: data)
    }
}

fileprivate extension JSONDecoder {
    static let requestJsonDecoder: JSONDecoder = .init()
}
