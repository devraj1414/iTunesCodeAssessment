//
//  UIImage+Cache.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 15/02/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageUsingCache (_ url : URL) {
        let imageCache = NSCache<AnyObject, AnyObject>()
        if let cachedImage = imageCache.object(forKey: url as AnyObject) {
            self.image = cachedImage as? UIImage
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data != nil {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: url as AnyObject)
                    DispatchQueue.main.async(execute: {
                        self.image = image
                    })
                }
            }
        }.resume()
    }
}
