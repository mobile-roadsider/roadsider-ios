//
//  RSPostDetailsController.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 1/5/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import UIKit
import SafariServices

class RSPostDetailsViewController : UIViewController {
    var viewModel : RSPostDetailsViewModelProtocol
    weak var coordinator: RSPostDetailsCoordinator?
    
    lazy var detailsView : RSPostDetailsView = {
        let view = RSPostDetailsView(viewModel:self.viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        self.scrollView.addSubview(view)
        return view
    }()
    
    // Mark: Initialization
    init(viewModel:RSPostDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.detailsView.layoutSubviews()
        self.scrollView.layoutSubviews()
        scrollView.contentSize = CGSize(width: detailsView.frame.width, height: detailsView.frame.height)
    }
    
    func setupView() {
        NSLayoutConstraint.activate([
            scrollView.alignTop(toView: self.view),
            scrollView.alignLeft(toView: self.view),
            scrollView.alignBottom(toView: self.view),
            scrollView.alignRight(toView: self.view),
            detailsView.alignTop(toView: scrollView),
            detailsView.alignBottom(toView: scrollView),
            detailsView.matchWidth(toView: scrollView)
            ])
    }
    
    fileprivate lazy var scrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        self.view.addSubview(view)
        return view
    }()
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            self.viewModel.userTappedBackButton()
        }
    }
}

extension RSPostDetailsViewController : RSCoordinated {

    func getCoordinator() -> RSCoordinator? {
        return coordinator
    }

    func setCoordinator(_ coordinator: RSCoordinator) {
        self.coordinator = coordinator as? RSPostDetailsCoordinator
    }
}

extension RSPostDetailsViewController : RSPostDetailsViewDelegate {
    func videoLinkTapped() {
        guard let videoLink = self.viewModel.postViewModel.videoLink else {
            return
        }
        let svc = SFSafariViewController(url: videoLink)
        svc.navigationController?.navigationBar.backgroundColor = RSColor.brandColor(.primary)
        self.present(svc, animated: true, completion: nil)
    }
    
    func openContentLinks(URL:URL) {
        let svc = SFSafariViewController(url: URL)
        self.present(svc, animated: true, completion: nil)
    }
}

