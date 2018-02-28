//
//  RSPostDetailsViewModel.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 1/7/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import Foundation

protocol RSPostDetailsViewModelCoordinatorDelegate : class  {
    func postDetailsViewModelFinish()
}

protocol RSPostDetailsViewModelProtocol {
    var coordinatorDelegate : RSPostDetailsViewModelCoordinatorDelegate? {get set}
    func userTappedBackButton()
    var postViewModel : RSPostViewModel {get}
}

class RSPostDetailsViewModel : RSPostDetailsViewModelProtocol {
    weak var coordinatorDelegate : RSPostDetailsViewModelCoordinatorDelegate?
    let postViewModel : RSPostViewModel
    init(viewModel: RSPostViewModel) {
        postViewModel = viewModel
    }
    
    func userTappedBackButton() {
        coordinatorDelegate?.postDetailsViewModelFinish()
    }
}
