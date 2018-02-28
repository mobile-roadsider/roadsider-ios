//
//  RSSectionViewCell.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 12/24/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit

class RSSectionViewCell : UICollectionViewCell {
    
    private lazy var stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 2
        self.addSubview(stack)
        return stack
    }()
    
    private lazy var comingSoonLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        label.font = RSFont.brandFont(.bold(size: 14))
        self.insertSubview(label, aboveSubview: stackView)
        return label
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        stackView.addArrangedSubview(imageView)
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = RSColor.brandColor(.secondary)
        label.font = RSFont.brandFont(.semiBold(size: 14))
        stackView.addArrangedSubview(label)
        return label
    }()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.backgroundColor = RSColor.brandColor(.primary)
        setupConstraints()
    }

    private func comingSoonConstraints() -> [NSLayoutConstraint] {
       return [comingSoonLabel.alignVertically(toView: self),
         comingSoonLabel.alignHorizontally(toView: self),
        comingSoonLabel.matchWidth(toView: self),
        comingSoonLabel.matchHeight(toView: self)]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(viewModel:RSSectionViewModel?) {
        guard let viewModel = viewModel else {
            return
        }
        imageView.image = UIImage(named: viewModel.sectionImage)
        titleLabel.text = viewModel.sectionName
        if viewModel.isDisabled {
            comingSoonLabel.text = "COMING SOON..."
            NSLayoutConstraint.activate(comingSoonConstraints())
            self.isUserInteractionEnabled = false
        } else {
            comingSoonLabel.text = ""
            NSLayoutConstraint.deactivate(comingSoonConstraints())
        }
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([stackView.alignVertically(toView: self),
                                     stackView.alignHorizontally(toView: self)])
    }
}
