//
//  YQPostsResponse.swift
//  YQDataLayer
//
//  Created by Niyaz Ahmed Amanullah on 10/22/17.
//  Copyright © 2017 Yaqeen. All rights reserved.
//

import Foundation

// Post Response Object
public struct YQPostsResponse : Codable {
    
    public struct PostTitle : Codable {
        public let rendered : String
    }

    public struct Content : Codable {
        public let rendered : String
    }

    public struct Excerpt : Codable {
       public let rendered : String
    }
    
    public let postId : Int
    public let postLink : URL?
    public let title : PostTitle
    public let content : Content
    public let authorName: String
    public let imageUrl: URL
    public let videoLink: [String]?
    public let date : String
    
    enum CodingKeys:String, CodingKey {
        case postId = "id"
        case date = "date"
        case postLink = "link"
        case title = "title"
        case content = "content"
        case authorName = "jk_author_name"
        case imageUrl = "jk_post_image_url"
        case videoLink = "jk_post_video_url"
    }

}
