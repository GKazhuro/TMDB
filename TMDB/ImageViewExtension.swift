//
//  ImageViewExtension.swift
//  TMDB
//
//  Created by Георгий Кажуро on 08.09.16.
//  Copyright © 2016 Георгий Кажуро. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadedFrom(_ link: String, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        contentMode = mode
        clipsToBounds = true
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse , httpURLResponse.statusCode == 200,
                let data = data , error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async(execute: {
                self.image = image
            });
            }) .resume()
    }
}
