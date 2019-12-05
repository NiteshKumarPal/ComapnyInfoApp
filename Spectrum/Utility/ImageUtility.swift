//
//  ImageUtility.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 05/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    func loadImage(url: URL?) {
        if let imageURL = url {
            sd_setImage(with: imageURL)
        }
    }
}
