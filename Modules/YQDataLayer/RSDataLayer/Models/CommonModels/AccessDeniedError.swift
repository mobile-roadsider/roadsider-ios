//
//  AccessDeniedError.swift
//  RSDataLayer
//
//  Created by Niyaz Ahmed Amanullah on 10/23/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation

//{
//    "code": "itsec_rest_api_access_restricted",
//    "message": "You do not have sufficient permission to access this endpoint. Access to REST API requests is restricted by iThemes Security settings.",
//    "data": null
//}

struct AccessDenied : Codable, Error {
    let code : String
    let message : String
    let data : Data
}
