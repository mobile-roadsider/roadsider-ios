//
//  RSPostRequest.swift
//  RSNetworking
//
//  Created by Niyaz Ahmed Amanullah on 10/22/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Alamofire
import RSDataLayer
import RSUtils

/**
 Post Requests Enum conforming to RSHttpServiceEndpoint protocol
 */
public enum RSPostRequest : RSHttpServiceEndpoint {
    case fetchAllPost(query:RSPostQuery)
    case fetchPostBy(postId:Int)
    
    public var baseUrl: String {
        guard let baseUrl = ServerConfigurationHandler.sharedInstance.serverConfig?.urls.baseUrl else {
            return ""
        }
        return String(format:"%@/wp-json/wp/v2/posts/?",baseUrl)
    }
    
    public var path : String {
        switch self {
        case .fetchPostBy(let postId):
            return String(postId)
        default:
            return ""
        }
    }

    public var parameters: Parameters {
        var body: Parameters = Parameters()
        body["fields"] = "id,title,link,date,content.rendered,jk_author_name,jk_post_image_url,jk_post_video_url"
        body["lang"] = "en"
        switch self {
        case .fetchAllPost(let query):
            body.merge(withDictionary: query.asDictionary())
        default:break
            
        }
        return body
    }
}

