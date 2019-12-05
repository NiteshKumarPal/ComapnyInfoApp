//
//  CompanyViewModel.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 06/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation
import UIKit

typealias FollowUIInfo = (followText: String, followImage: UIImage)

class CompanyViewModel {
    var id = ""
    var companyName = ""
    var logo: URL?
    var description = ""
    var website: URL?
    var memberViewModelList: [MemberViewModel]? = []
    var isFollowing = false {
        didSet {
            updateFollowUIInfo(isFollowed: isFollowing)
        }
    }
    var followingText = CompanyPresenterConstants.unFollowingInfo.followText
    var followImage = CompanyPresenterConstants.unFollowingInfo.followImage
    
    init() {}
    
    func updateFollowUIInfo(isFollowed: Bool) {
        followingText = isFollowing ? CompanyPresenterConstants.followingInfo.followText :
            CompanyPresenterConstants.unFollowingInfo.followText
        
        followImage = isFollowing ? CompanyPresenterConstants.followingInfo.followImage :
            CompanyPresenterConstants.unFollowingInfo.followImage
    }
}

struct CompanyPresenterConstants {
    static let followingInfo: FollowUIInfo = (followText: "Following", followImage: UIImage(systemName: "hand.thumbsup.fill") ?? UIImage())
    
    static let unFollowingInfo: FollowUIInfo = (followText: "Follow", followImage: UIImage(systemName: "hand.thumbsup") ?? UIImage())
    
    static let title = "Company list"
}
