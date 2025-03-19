//
//  JSONDataRequest.swift
//  Requests
//
//  Created by Evgenii Kononenko on 16.03.25.
//

import Foundation

public protocol JSONDataDecoding: DataDecoding {
    var decoder: JSONDecoder { get }
}

public extension JSONDataDecoding where Output: Decodable {
    func decode(_ data: Data) throws -> Output {
        return try decoder
            .decode(Output.self, from: data)
    }

    var decoder: JSONDecoder {
        JSONDecoder.requestsJsonDecoder
    }
}

fileprivate extension JSONDecoder {
    static let requestsJsonDecoder: JSONDecoder = .init()
}
