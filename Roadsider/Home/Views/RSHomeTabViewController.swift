//
//  RSHomeTabViewController.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 1/6/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import UIKit
import RSUtils
import RSDataLayer
import SafariServices

class RSHomeTabViewController : UIViewController {
    
    // Mark: Initialization
    fileprivate(set) var viewModel : RSHomeTabViewModelProtocol
    
    fileprivate var cellTapped : Bool = false
    init(viewModel:RSHomeTabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        presentWelcomeAlert()
        self.activityIndicator.startAnimating()
        if(self.viewModel.fetchImmediately) {
            self.viewModel.fetchPosts(query:RSPostQuery(offset: 0, tagId:self.viewModel.sectionId)) { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.collectionView.reloadData()
            }
        } else {
            NotificationCenter.default.addObserver(forName:RSNotificationConstants.kAppStartedNotification, object:nil, queue:nil, using:appStarted)
            
        }
        self.automaticallyAdjustsScrollViewInsets = false
        setupRefreshControl()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cellTapped = false
    }
    
    func setupNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title =  self.viewModel.navigationTitle
        self.navigationController?.navigationBar.titleTextAttributes  = [NSAttributedStringKey.font: RSFont.brandFont(.bold(size: 18)), NSAttributedStringKey.foregroundColor:RSColor.brandColor(.secondary)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK : File Private Methods
    fileprivate func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = RSColor.brandColor(.primary)
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing Posts...")
        refreshControl.addTarget(self,
                                 action: #selector(refreshOptions(sender:)),
                                 for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
    }
    
    fileprivate func presentWelcomeAlert() {
        if !UserDefaults.ClientConfiguration.bool(forKey: .isWelcomeAlertDisplayed) {
            UserDefaults.ClientConfiguration.set(true, forKey: .isWelcomeAlertDisplayed)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            self.presentAlertController(title:"", message:"Salaam and Welcome to Roadsider’s iOS App. This is our initial release with basic features. Over the next few months we’ll be adding additional features and resolving issues as they arise. If you find an issue, have any questions or concerns please reach out to us at info@Roadsiderinstitute.org", actions:okAction)
        }
    }
    
    func refreshAfterCompletion() {
        collectionView.performBatchUpdates({
            let indexSet = IndexSet(integer: 0)
            self.collectionView.reloadSections(indexSet)
        }, completion: nil)
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        self.view.isUserInteractionEnabled = false
        self.viewModel.fetchPosts(query:RSPostQuery(offset: 0,tagId:self.viewModel.sectionId)) { [weak self] in
            guard let _ = self?.viewModel.viewModels else {
                sender.endRefreshing()
                return
            }
            self?.collectionView.reloadData()
            sender.endRefreshing()
            self?.view.isUserInteractionEnabled = true
        }
    }
    
    // MARK : Lazy Vars
    fileprivate lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width:self.view.frame.width, height:320)
        flowLayout.minimumLineSpacing = 5
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        cv.dataSource = self
        cv.delegate = self
        cv.bounces = true
        cv.alwaysBounceVertical = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.lightGray
        cv.allowsMultipleSelection = false
        cv.register(RSPostCardView.self, forCellWithReuseIdentifier:"RSPostCardView")
        self.view.addSubview(cv)
        return cv
    }()
    
    // MARK : Lazy Vars
    fileprivate lazy var errorView: RSErrorView = {
        let view = RSErrorView(dataSource:RSErrorDataSource(image:UIImage(named: "BrandLogo"), line1:"Sorry folks we just lit a dumpster fire!!🔥", line2:"Bear with us as we try to put it out. 🚒",line3:"We'll be back soon."))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        //   self.view.addSubview(view)
        return view
    }()
    
    fileprivate lazy var activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.backgroundColor = UIColor.gray
        self.view.addSubview(activity)
        return activity
    }()
    
    // MARK : Private Methods
    private func setupConstraints() {
        var constraintCollection = [NSLayoutConstraint]()
        constraintCollection.append(contentsOf: collectionView.attachToSuperView())
        constraintCollection.append(contentsOf: self.activityIndicator.attachToSuperView())
        NSLayoutConstraint.activate(constraintCollection)
        self.view.bringSubview(toFront: self.activityIndicator)
    }
    
    fileprivate func configureErrorView(activate:Bool) {
        let constraints = [errorView.alignVertically(toView: self.view),
                           errorView.alignHorizontally(toView:self.view)]
        if activate {
            self.view.addSubview(errorView)
            NSLayoutConstraint.activate(constraints)
        } else {
            self.errorView.removeFromSuperview()
        }
    }
}

// MARK : Notification functions
extension RSHomeTabViewController {
    fileprivate func appStarted(_ notification:Notification) {
        NotificationCenter.default.removeObserver(self, name: RSNotificationConstants.kAppStartedNotification, object: nil)
        self.viewModel.fetchPosts(query:RSPostQuery(offset: 0, tagId:self.viewModel.sectionId)) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.collectionView.reloadData()
        }
    }
}

//MARK: UICollectionViewDelegate
extension RSHomeTabViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !cellTapped else {
            return
        }
        self.viewModel.postTapped(viewModel: self.viewModel.viewModels[indexPath.item])
        cellTapped = true
    }
}

//MARK: RSHomeTabViewModelViewDelegate
extension RSHomeTabViewController: RSHomeTabViewModelViewDelegate {
    func fetchPostFailure() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else {return}
            self?.view.isUserInteractionEnabled = true
            self?.collectionView.refreshControl?.endRefreshing()
            weakSelf.activityIndicator.stopAnimating()
            weakSelf.collectionView.backgroundColor = RSColor.brandColor(.primary)
            weakSelf.collectionView.reloadData()
            weakSelf.configureErrorView(activate:true)
        }
    }
}

extension RSHomeTabViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RSPostCardView", for: indexPath) as! RSPostCardView
        cell.configureView(viewModel: self.viewModel.viewModels[indexPath.item])
        if indexPath.item ==  self.viewModel.viewModels.count - 1 && self.viewModel.hasMoreData {
            self.viewModel.fetchPosts(query:RSPostQuery(offset: self.viewModel.viewModels.count,tagId:self.viewModel.sectionId)) {
                self.refreshAfterCompletion()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.viewModels.count
    }
}

//MARK: RSPostCardViewDelegate
extension RSHomeTabViewController : RSPostCardViewDelegate {
    func videoLinkTapped(videoLink: URL?) {
        guard let link = videoLink else {
            return
        }
        let svc = SFSafariViewController(url: link)
        self.present(svc, animated: true, completion: nil)
    }
}

//MARK: RSErrorViewDelegate
extension RSHomeTabViewController : RSErrorViewDelegate {
    
    func retryButtonTapped() {
        self.activityIndicator.startAnimating()
        self.configureErrorView(activate:false)
        self.viewModel.fetchPosts(query:RSPostQuery(offset: 0, tagId:self.viewModel.sectionId)) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.collectionView.backgroundColor = .clear
            self?.collectionView.reloadData()
        }
    }
}
