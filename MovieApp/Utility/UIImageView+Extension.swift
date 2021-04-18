//
//  UIImageView+Extension.swift
//  MovieApp
//
//  Created by Lalit Kant on 17/04/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

/// Extension to load imageview asynchronously and save it to cache, Extension method has power to add placeholder image to ImageView
extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String, urlMain: URL, _ placeholderImageName: String?) {
        let url = urlMain
        self.image = nil
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        //showing activity loader until image is loaded
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        // if not, download image from url
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                DispatchQueue.main.async {
                    self.image = placeholderImageName != nil ? UIImage.init(named: placeholderImageName ?? "placeholder") : UIImage.init(named: "placeholder")
                    activityIndicator.removeFromSuperview()
                }
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }
        }).resume()
    }
}
