//
//  DataRequest.swift
//  Requests
//
//  Created by Evgenii Kononenko on 16.03.25.
//
import Foundation

public protocol DataRequest: Request {
    func decode(_ data: Data) throws -> Output
}
