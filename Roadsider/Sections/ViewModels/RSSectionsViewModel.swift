//
//  RSSectionsViewModel.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 12/25/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import RSNetworking
import RSDataLayer

protocol RSSectionsViewModelCoordinatorDelegate : class {
    func sectionTapped(viewModel: RSSectionViewModel)
}

protocol RSSectionsViewModelProtocol {
    var sections : [RSSectionViewModel] {get}
    var sectionTitle :  String {get}
    func sectionTapped(viewModel:RSSectionViewModel)
    var coordinatorDelegate : RSSectionsViewModelCoordinatorDelegate? {get set}
}

struct RSSectionsViewModel :RSSectionsViewModelProtocol {
    weak var coordinatorDelegate : RSSectionsViewModelCoordinatorDelegate?
    private(set) var sections : [RSSectionViewModel]
    let sectionTitle :  String
    init() {
        self.sectionTitle = "Research"
        self.sections = [
            RSSectionViewModel(id:83, sectionImage: "Publications", sectionName: "Publications",isDisabled:false),
            RSSectionViewModel(id:84, sectionImage: "Articles", sectionName: "Articles",isDisabled:false),
            RSSectionViewModel(id:85, sectionImage: "Lectures", sectionName: "Lectures",isDisabled:false),
            RSSectionViewModel(id:96, sectionImage: "QandA", sectionName: "Q/A",isDisabled:false),
            RSSectionViewModel(id:153, sectionImage: "Infographics", sectionName: "Infographics",isDisabled:true),
            RSSectionViewModel(id:1, sectionImage: "AudioBooks", sectionName: "Audio Books",isDisabled:true),
            RSSectionViewModel(id:1, sectionImage: "RoadsiderSeries", sectionName: "Roadsider Series",isDisabled:true)
        ]
    }
    
    func sectionTapped(viewModel: RSSectionViewModel) {
        coordinatorDelegate?.sectionTapped(viewModel:viewModel)
    }
}
