//
//  YQPostQuery.swift
//  YQDataLayer
//
//  Created by Niyaz Ahmed Amanullah on 11/4/17.
//  Copyright © 2017 YQDataLayer. All rights reserved.
//

import Foundation

// Model for defining the request params for fetching posts
public struct YQPostQuery : Codable {
    public let page : Int
    public let limit : Int
    public let offset : Int
    public let tagId : String?
    public let tagsExclude:String?
    
    public init(page:Int = 1, limit:Int = 15, offset:Int = 0, tagId: String? = nil, tagsExclude:String? = "153,1") {
        self.page = page
        self.limit = limit
        self.offset = offset
        self.tagId = tagId
        self.tagsExclude = tagsExclude
    }
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case limit = "per_page"
        case offset = "offset"
        case tagId = "tags"
        case tagsExclude = "tags_exclude"
    }
}


extension Encodable {
    public func asDictionary() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return [:]
            }
            return dictionary
        } catch {
            print("Error deserializing Object \(self)")
        }
        return [:]
    }
}
