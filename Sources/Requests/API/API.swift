//
//  API.swift
//  Requests
//
//  Created by Evgenii Kononenko on 16.03.25.
//

public enum API {
    public enum Method: String {
        case get = "GET"
    }

    public enum Scheme: String {
        case https = "HTTPS"
    }

    public enum Error: Swift.Error {
        case invalidRequest
        case invalidResponse(statusCode: Int?)
    }
}
