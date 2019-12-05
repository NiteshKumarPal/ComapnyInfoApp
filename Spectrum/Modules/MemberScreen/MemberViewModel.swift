//
//  MemberViewModel.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 06/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation
import UIKit

class MemberViewModel {
    var id = ""
    var age = ""
    var name = ""
    var email = ""
    var phone = ""
    var isFavorite = false
    var favourateImage: UIImage { return UIImage(systemName: isFavorite ? "star.fill" : "star") ?? UIImage() }
    
    init() {}
}
