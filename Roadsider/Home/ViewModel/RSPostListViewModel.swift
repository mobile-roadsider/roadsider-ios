//
//  RSPostListViewModel.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 1/11/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import Foundation
import RSDataLayer
import RSNetworking

protocol RSPostListViewModelProtocol {
    var viewModels : [RSPostViewModel] {get}
    func fetchPosts(query:RSPostQuery, completion: (() -> ())?)
    var hasMoreData : Bool {get}
}

class RSPostListViewModel : RSPostListViewModelProtocol {
    private let service : RSPostsServiceProtocol
    private var moreDataAvaialble = true
    var viewModels : [RSPostViewModel] = []
    init(service: RSPostsServiceProtocol) {
        self.service = service
    }
    
    /**
     Fetches all the posts from given offset
     - Parameters:
     - offset: Integer from which the result set has to be returned
     - completion: Completion Block to be executed after Response
     */
    func fetchPosts(query:RSPostQuery, completion: (() -> ())? = nil) {
        if query.offset == 0  {
            self.viewModels.removeAll()
        }
        self.service.fetchPosts(endPoint:RSPostRequest.fetchAllPost(query:query)) { [unowned self] (result) in
            switch result {
            case .success(let response):
                guard !response.isEmpty else {
                    self.moreDataAvaialble = false
                    return
                }
                let viewModels = response.flatMap {
                    return RSPostViewModel(post: $0)
                }
                self.viewModels.append(contentsOf:viewModels)
                completion?()
            case .error(let error):
                // We will handle this once we have our app running with features. Do not want to spend time right now.
                print("\(error)")
                self.moreDataAvaialble = false
            }
        }
    }
    
    var hasMoreData : Bool {
        return self.moreDataAvaialble
    }
}
