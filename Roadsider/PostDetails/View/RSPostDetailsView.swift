
//
//  RSPostDetailsView.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 1/7/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import UIKit

protocol RSPostDetailsViewDelegate : class {
    func videoLinkTapped()
    func openContentLinks(URL:URL)
}

/// View for Post Details
class RSPostDetailsView : UIView {
    
    let viewModel : RSPostDetailsViewModelProtocol
    weak var delegate : RSPostDetailsViewDelegate?
    init(viewModel: RSPostDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.preferredMaxLayoutWidth = self.frame.width
        self.authorLabel.preferredMaxLayoutWidth = self.frame.width
        self.stackView.layoutSubviews()
        self.mainStack.layoutSubviews()
        layoutIfNeeded()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.white
        configureView()
    }
    
    func configureView() {
        self.imageView.set_image(url:viewModel.postViewModel.imageUrl, placeholderImage: UIImage(named: "MainCardPlaceHolder.png"))
        self.titleLabel.text = viewModel.postViewModel.title
        self.authorLabel.text = viewModel.postViewModel.authorName
        configureContentTextView()
        configureStackView()
        configureVideoLink()
    }
    
    private func configureVideoLink() {
        if let _ = viewModel.postViewModel.videoLink {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(videoTapped))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
            setupVideoLink()
        }
    }
    
    private func configureContentTextView() {
        self.activityIndicator.startAnimating()
        self.viewModel.postViewModel.content.attributedStringFromHTML { attributedString in
            self.contentTextView.attributedText = attributedString?.attributedStringByTrimmingCharacterSet(charSet: .whitespacesAndNewlines)
            self.activityIndicator.stopAnimating()
            self.layoutIfNeeded()
        }
    }
    
    private func configureStackView() {
        self.stackView.addArrangedSubview(contributionLabel)
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(authorLabel)
        self.stackView.addArrangedSubview(activityIndicator)
        self.stackView.addArrangedSubview(contentTextView)
        
        self.mainStack.addArrangedSubview(imageView)
        self.mainStack.addArrangedSubview(self.stackView)
        
        if #available(iOS 11.0, *) {
            stackView.setCustomSpacing(1.0, after: titleLabel)
            stackView.setCustomSpacing(5.0, after: authorLabel)
        }
        
        imageView.matchWidth(toView: self.mainStack).isActive = true
        
        var constraintCollection = [NSLayoutConstraint]()
        constraintCollection.append(contentsOf: self.mainStack.attachToSuperView())
        constraintCollection.append(self.activityIndicator.alignVertically(toView: self.mainStack))
        NSLayoutConstraint.activate(constraintCollection)
    }
    
    private func setupVideoLink() {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named:"VideoImage.png")
        self.insertSubview(image, aboveSubview: imageView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(videoTapped))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
        image.alignTrailing(toView: imageView, offset: 20).isActive = true
        image.alignBottom(toView: imageView, offset: 20).isActive = true
    }
    
    @objc func videoTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        delegate?.videoLinkTapped()
    }
    
    // MARK: Lazy Vars
    fileprivate lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 2
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    fileprivate lazy var mainStack : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        self.addSubview(stackView)
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
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
    
    lazy var  contentTextView : UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.dataDetectorTypes = UIDataDetectorTypes.link
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.font = RSFont.brandFont(.regular(size: 14))
        return textView
    }()
    
    fileprivate lazy var activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.backgroundColor = UIColor.clear
        activity.color = RSColor.brandColor(.secondary)
        return activity
    }()
}

extension RSPostDetailsView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        self.layoutIfNeeded()
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        self.delegate?.openContentLinks(URL:URL)
        return false
    }
}
