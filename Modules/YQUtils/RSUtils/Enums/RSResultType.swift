//
//  RSResultType.swift
//  RSUtils
//
//  Created by Niyaz Ahmed Amanullah on 11/11/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation

/**
 ResultType enum that will handle the success and error case for a request
 */
public enum RSResultType<SuccessValue,ErrorValue> {
    case success(SuccessValue)
    case error(ErrorValue)
}

/** Enumeration of Custom Roadsider related Error Type
 - customError: Provides an error message that conforms to Decodable protocol
 */
public enum RSError : Error {
    case customError(Decodable)
}
