//
//  RSSectionsViewController.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 12/24/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit
import RSDataLayer

class RSSectionsViewController : UIViewController {
    
    var viewModel : RSSectionsViewModelProtocol
    
    // Mark: Initialization
    init(viewModel:RSSectionsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        collectionView.backgroundColor = UIColor.white
        setupConstraints()
        self.collectionView.reloadData()
    }
    
    func setupNavigation() {
        self.navigationItem.title =  self.viewModel.sectionTitle
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
    
    private func setupConstraints() {
        var constraintCollection = [NSLayoutConstraint]()
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            constraintCollection.append(collectionView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0))
        } else {
            constraintCollection.append(collectionView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0))
        }
        constraintCollection.append(collectionView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0))
        constraintCollection.append(contentsOf: collectionView.layoutHorizontal(margin: 0))
        NSLayoutConstraint.activate(constraintCollection)
    }
    
    // MARK: Lazy Var
    fileprivate lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.bounces = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.lightGray
        cv.register(RSSectionViewCell.self, forCellWithReuseIdentifier:"RSSectionViewCell")
        self.view.addSubview(cv)
        return cv
    }()
}

// MARK : RSVerticalCollectionViewDelegate
extension RSSectionsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns : CGFloat = 3
        let itemWidth = (self.collectionView.frame.width - (numberOfColumns-1))/numberOfColumns
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

//MARK: UICollectionViewDelegate
extension RSSectionsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentSection = self.viewModel.sections[indexPath.item]
        self.viewModel.sectionTapped(viewModel: currentSection)
    }
    
}

extension RSSectionsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RSSectionViewCell", for: indexPath) as! RSSectionViewCell
        cell.configureView(viewModel: self.viewModel.sections[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.sections.count
    }
}


