//
//  UIImageView+RSAdditions.swift
//  RSUtils
//
//  Created by Niyaz Ahmed Amanullah on 11/10/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import AlamofireImage

// Roadsider Specific Image View Extension that calls AlamfofireImage for setting image on imageview
extension UIImageView {
    
    /**
     Sets the image on the ImageView with a PlaceHolderImage
     - Parameters:
        -  url: String - Url path of the image
        -  placeholderImage: UIImage placeholder image until Image is loaded
        -  completion : optional Block to be executed after the image response
     */
   public func set_image(url:String, placeholderImage: UIImage?,  completion: ((RSResultType<UIImage,Error>) ->())? = nil) {
        let imageUrl = URL(string:url)
    self.af_setImage(withURL: imageUrl!, placeholderImage: placeholderImage, imageTransition: .crossDissolve(0.2))
    }

    /**
     Sets the image on the ImageView with a PlaceHolderImage
     - Parameters:
     -  url: String - Url path of the image
     -  placeholderImage: UIImage placeholder image until Image is loaded
     -  completion : optional Block to be executed after the image response
     */
    public func set_image(url:URL, placeholderImage: UIImage?,  completion: ((RSResultType<UIImage,Error>) ->())? = nil) {
        self.af_setImage(withURL: url, placeholderImage: placeholderImage) { response in
            switch response.result {
            case .success(let data):
                completion?(.success(data))
            case .failure(let error):
                completion?(.error(error))
            }
        }
    }
}
