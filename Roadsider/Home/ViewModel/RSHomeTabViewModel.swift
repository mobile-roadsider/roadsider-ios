//
//  HomeViewModel.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/22/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import RSNetworking
import RSDataLayer
import Crashlytics

protocol RSHomeTabViewModelCoordinatorDelegate : class {
    func homeTabViewModelDidFinish(postViewModel:RSPostViewModel)
}

protocol RSHomeTabViewModelViewDelegate : class {
    func fetchPostFailure()
}

protocol RSHomeTabViewModelProtocol {
    var viewModels : [RSPostViewModel] {get}
    var coordinatorDelegate : RSHomeTabViewModelCoordinatorDelegate? {get set}
    var viewDelegate : RSHomeTabViewModelViewDelegate? {get set}
    func fetchPosts(query:RSPostQuery, completion: (() -> ())?)
    func postTapped(viewModel:RSPostViewModel?)
    var hasMoreData : Bool {get}
    var fetchImmediately : Bool {get}
    var sectionId : String?  {get}
    var navigationTitle:String {get}
}

/**
 Main View Model for the Home Tab
 */
class RSHomeTabViewModel : RSHomeTabViewModelProtocol{
    weak var coordinatorDelegate : RSHomeTabViewModelCoordinatorDelegate?
    weak var viewDelegate: RSHomeTabViewModelViewDelegate?
    private let service : RSPostsServiceProtocol
    let navigationTitle : String
    private var moreDataAvaialble = true
    var viewModels : [RSPostViewModel] = []
    let fetchImmediately : Bool
    private(set) var sectionId : String?
    init(service: RSPostsServiceProtocol, fetchImmediately:Bool = false, navigationTitle:String = "") {
        self.service = service
        self.fetchImmediately = fetchImmediately
        self.navigationTitle = navigationTitle
        
    }
    
    convenience init(service:RSPostsServiceProtocol, sectionId:Int, fetchImmediately:Bool = false , navigationTitle:String = "") {
        self.init(service: service,fetchImmediately:fetchImmediately, navigationTitle:navigationTitle)
        self.sectionId = String(sectionId)
    }
    
    func postTapped(viewModel:RSPostViewModel?) {
        guard let postViewModel = viewModel else {
            return
        }
        coordinatorDelegate?.homeTabViewModelDidFinish(postViewModel:postViewModel)
    }
    
    /**
     Fetches all the posts from given offset
     - Parameters:
     - query: Integer from which the result set has to be returned
     - completion: Completion Block to be executed after Response
     */
    func fetchPosts(query:RSPostQuery, completion: (() -> ())? = nil) {
        self.service.fetchPosts(endPoint:RSPostRequest.fetchAllPost(query:query)) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard !response.isEmpty else {
                    self?.moreDataAvaialble = false
                    return
                }
                let viewModels = response.flatMap {return RSPostViewModel(post: $0)}
                if query.offset == 0 {
                    self?.viewModels = viewModels
                } else {
                    self?.viewModels.append(contentsOf:viewModels)
                }
                self?.moreDataAvaialble = true
                completion?()
            case .error(let error):
                Crashlytics.sharedInstance().recordError(error)
                self?.viewModels.removeAll()
                self?.viewDelegate?.fetchPostFailure()
                self?.moreDataAvaialble = false
            }
        }
    }
    
    var hasMoreData : Bool {
        return self.moreDataAvaialble
    }
}

struct RSPostViewModel  {
    
    static let kHTML = """
    <html>
    <head>
    <style type="text/css">
    body {
    font-size: 14px;
    font-family: Montserrat-Regular;
    color: #000000;
    }
    h1,h2,h3 {
    font-family: Montserrat-Bold;
    color: #80A9E9;
    }
    </style>
    </head>
    <body>
    %@
    </body>
    </html>
    """
    
    let title : String
    let authorName : String
    let imageUrl : URL
    let content : String
    private(set) var videoLink : URL? = nil
    init(post :RSPostsResponse) {
        title = post.title.rendered.decodingHTMLEntities()
        authorName = post.authorName
        imageUrl = post.imageUrl
        if let link = post.videoLink?.first {
            videoLink = URL(string:link)
        }
        content =  String(format:RSPostViewModel.kHTML, post.content.rendered.decodingHTMLEntities())
    }
}
