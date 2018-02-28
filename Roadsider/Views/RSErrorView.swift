//
//  RSErrorView.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 1/17/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import UIKit

struct RSErrorDataSource {
    let image  : UIImage?
    let line1 : String?
    let line2: String?
    let line3: String?

}

protocol RSErrorViewDelegate : NSObjectProtocol {
    func retryButtonTapped()
}

class RSErrorView : UIView {
    
    weak var delegate : RSErrorViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }
    
    let dataSource : RSErrorDataSource
    init(dataSource: RSErrorDataSource) {
        self.dataSource = dataSource
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    fileprivate func setupView() {
        let line1 = UILabel()
        line1.text = dataSource.line1
        line1.textColor = .white
        line1.font = RSFont.brandFont(.regular(size: 18))
        line1.textAlignment = .center
        
        let line2 = UILabel()
        line2.text = dataSource.line2
        line2.textColor = .white
        line1.font = RSFont.brandFont(.regular(size: 18))
        line2.textAlignment = .center
        
        let line3 = UILabel()
        line3.text = dataSource.line3
        line3.textColor = RSColor.brandColor(.secondary)
        line3.font = RSFont.brandFont(.extraBold(size: 18))
        line3.textAlignment = .center
        
        stackView.addArrangedSubview(line1)
        stackView.addArrangedSubview(line2)
        stackView.addArrangedSubview(line3)
        stackView.addArrangedSubview(retryButton)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            brandLogo.alignVertically(toView: self),
            brandLogo.alignTop(toView:self),
            brandLogo.pinBottom(stackView,offset: 30),
            stackView.alignLeading(toView:self),
            stackView.alignTrailing(toView: self),
            stackView.alignBottom(toView: self)])

    }
    
    @objc func retryButtonTapped(sender:UITapGestureRecognizer) {
        self.delegate?.retryButtonTapped()
    }
    
    
    // MARK : Lazy Vars
    private lazy var stackView : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 5
        self.addSubview(view)
        return view
    }()
    
    private lazy var brandLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  dataSource.image
        imageView.makeHeight(75).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        return imageView
    }()
    
    private lazy var retryButton : UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .center
        button.setTitle("Retry",for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = RSColor.brandColor(.secondary)
        button.titleLabel?.font = RSFont.brandFont(.medium(size: 18))
        button.roundedCorners(cornerRadius: 0.8)
        addTapRecognizer(view:button,action: #selector(RSErrorView.retryButtonTapped))
        return button
    }()
    
    private func addTapRecognizer(view:UIView,action: Selector?){
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tap)
    }
}
