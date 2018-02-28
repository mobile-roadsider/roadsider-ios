//
//  RSPostCardView.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/25/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit
import RSUtils

protocol RSPostCardViewDelegate : class {
    func videoLinkTapped(videoLink:URL?)
}

class RSPostCardView : UICollectionViewCell {
    
    weak var delegate : RSPostCardViewDelegate?
    // MARK: Lazy Vars
    fileprivate lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 2
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        contentView.addSubview(stackView)
        return stackView
    }()
    
    fileprivate lazy var mainStack : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        contentView.addSubview(stackView)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.preferredMaxLayoutWidth = self.frame.width - 20
        self.authorLabel.preferredMaxLayoutWidth = self.frame.width - 20
        layoutIfNeeded()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.white
        setupStackView()
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.isAccessibilityElement = false
        image.makeWidth(Float(self.frame.width)).isActive = true
        image.makeHeight(210).isActive = true
        return image
    }()
    
    lazy var contributionLabel : UILabel = {
        let label = UILabel()
        label.text = "CONTRIBUTION"
        label.font = RSFont.brandFont(.semiBold(size: 10))
        label.textColor = RSColor.brandColor(.secondary)
        label.setContentHuggingPriority(.defaultHigh, for: UILayoutConstraintAxis.vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: UILayoutConstraintAxis.vertical)
        return label
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.font = RSFont.brandFont(.bold(size: 20))
        label.textColor = RSColor.brandColor(.primary)
        label.setContentHuggingPriority(.defaultHigh, for: UILayoutConstraintAxis.vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: UILayoutConstraintAxis.vertical)
        return label
    }()
    
    lazy var authorLabel : UILabel = {
        let label = UILabel()
        label.font = RSFont.brandFont(.medium(size: 10))
        label.textColor = RSColor.brandColor(.secondary1)
        label.setContentHuggingPriority(.defaultLow, for: UILayoutConstraintAxis.vertical)
        label.setContentCompressionResistancePriority(.defaultLow, for: UILayoutConstraintAxis.vertical)
        return label
    }()
    
    lazy var videoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(image, aboveSubview: imageView)
        image.alignTrailing(toView: imageView, offset: 20).isActive = true
        image.alignBottom(toView: imageView, offset: 20).isActive = true
        return image
    }()
    
    func configureView(viewModel:RSPostViewModel?) {
        guard let postViewModel = viewModel else {
            return
        }
        self.imageView.set_image(url:postViewModel.imageUrl, placeholderImage: UIImage(named: "MainCardPlaceHolder.png"))
        self.titleLabel.text = postViewModel.title
        self.authorLabel.text = postViewModel.authorName

        if let _ = postViewModel.videoLink {
            videoImage.image = UIImage(named:"VideoImage.png")
        } else {
            videoImage.image = nil
        }
        layoutIfNeeded()
    }
    
    private func setupStackView() {
        self.stackView.addArrangedSubview(contributionLabel)
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(authorLabel)
        
        self.mainStack.addArrangedSubview(imageView)
        self.mainStack.addArrangedSubview(self.stackView)
        
        if #available(iOS 11.0, *) {
            stackView.setCustomSpacing(1.0, after: titleLabel)
        }
        NSLayoutConstraint.activate(self.mainStack.attachToSuperView(insets: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)))
    }
}
