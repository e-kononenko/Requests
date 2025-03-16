//
//  APIRequest.swift
//  Requests
//
//  Created by Evgenii Kononenko on 16.03.25.
//
import Foundation

public protocol APIRequest: Request, DataRequest {
    var scheme: API.Scheme { get }
    var host: String { get }
    var path: String { get }
    var method: API.Method { get }
    var parameters: [String: String] { get }
}

public extension APIRequest {
    private func toURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard var urlRequest = components.url.map({ URLRequest(url: $0) }) else {
            throw API.Error.invalidRequest
        }
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }

    func fetch() async throws -> Output {
        let urlRequest = try toURLRequest()
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw API.Error.invalidResponse(statusCode: nil)
        }

        guard 200 ..< 300 ~= statusCode else {
            throw API.Error.invalidResponse(statusCode: statusCode)
        }

        return try decode(data)
    }
}
