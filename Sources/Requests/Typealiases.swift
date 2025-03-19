//
//  Typealiases.swift
//  Requests
//
//  Created by Evgenii Kononenko on 19.03.25.
//

public typealias JSONAPIRequest = APIRequest & JSONDataDecoding
public typealias BundledFileRequestJSON = BundleFileRequest & JSONDataDecoding
