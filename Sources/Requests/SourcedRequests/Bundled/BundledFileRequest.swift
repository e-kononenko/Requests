//
//  BundledFileRequest.swift
//  Requests
//
//  Created by Evgenii Kononenko on 19.03.25.
//

import Foundation

public protocol BundledFileRequest: Request, DataDecoding {
    var bundle: Bundle { get }
    var fileName: String { get }
    var fileExtension: String { get }
}

public extension BundledFileRequest where Output: Decodable {
    var bundle: Bundle { .main }

    func fetch() async throws -> Output {
        guard let fileURL = bundle.url(forResource: fileName, withExtension: fileExtension) else {
            throw Bundled.Error.notFound
        }

        let data = try Data(contentsOf: fileURL)
        return try decode(data)
    }
}
