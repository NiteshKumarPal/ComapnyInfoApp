//
//  CompanyViewPresenter.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 03/12/19.
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
    var followingText = "Follow"
    var followImage = UIImage(systemName: "hand.thumbsup")
    
    init() {}
    
    func updateFollowUIInfo(isFollowed: Bool) {
        followingText = isFollowing ? CompanyPresenterConstants.followingInfo.followText :
            CompanyPresenterConstants.unFollowingInfo.followText
        
        followImage = isFollowing ? CompanyPresenterConstants.followingInfo.followImage :
            CompanyPresenterConstants.unFollowingInfo.followImage
    }
}

class MemberViewModel {
    var id = ""
    var age = ""
    var name = ""
    var email = ""
    var phone = ""
    var isFavourate = false
    
    init() {}
}

struct CompanyPresenterConstants {
   static let followingInfo: FollowUIInfo = (followText: "Following", followImage: UIImage(systemName: "hand.thumbsup.fill") ?? UIImage())
    
   static let unFollowingInfo: FollowUIInfo = (followText: "Follow", followImage: UIImage(systemName: "hand.thumbsup") ?? UIImage())
}

protocol CompanyViewPresenterViewDelegate: class {
    func reloadData()
}

class CompanyViewPresenter {
    
    let companyWebService: CompanyWebServiceInterface? = CompanyWebService()
    var companyViewModelList = [CompanyViewModel]()
    weak var companyViewPresenterViewDelegate: CompanyViewPresenterViewDelegate?
    
    let title = "Company list"
    let follow = "Follow"
    let following = "Following"
    
    func fetchCompanyInfoData(completion: (() -> Void)? = nil) {
        companyWebService?.fetchCompanyInfoList { [weak self] (companyInfoList) in
            
            guard let selfInstance = self else { return }
            
            selfInstance.companyViewModelList = selfInstance.getCompanyViewModelFrom(companyInfoList: companyInfoList) ?? []
            
            selfInstance.companyViewPresenterViewDelegate?.reloadData()
            completion?()
        }
    }
    
    func getCompanyViewModelFrom(companyInfoList: [CompanyInfo]?) -> [CompanyViewModel]? {
        
        guard let companyInfoList = companyInfoList else { return [] }
        
        var companyViewModelList = [CompanyViewModel]()
        
        for company in companyInfoList {
            let companyViewModel = CompanyViewModel()
            companyViewModel.id = company.id ?? UUID().description
            companyViewModel.companyName = company.companyName ?? ""
            companyViewModel.description = company.description ?? ""
            companyViewModel.website = company.website
            companyViewModel.logo = company.logo
            companyViewModel.memberViewModelList = getMemberInfoModel(memberInfoModelList: company.memberInfoList)
            
            companyViewModelList.append(companyViewModel)
        }
        
        return companyViewModelList
    }
    
    func getMemberInfoModel(memberInfoModelList: [MemberInfo]?) -> [MemberViewModel] {
        guard let memberInfoModelList = memberInfoModelList else { return [] }
        
        var memberViewModelList = [MemberViewModel]()
        
        for member in memberInfoModelList {
            let memberViewModel = MemberViewModel()
            memberViewModel.id = member.id ?? UUID().description
            memberViewModel.name = "\(member.name?.first ?? "") \(member.name?.last ?? "")"
            memberViewModel.age = String(member.age ?? 0)
            memberViewModel.email = member.email ?? ""
            memberViewModel.phone = member.phone ?? ""
            
            memberViewModelList.append(memberViewModel)
        }
        
        return memberViewModelList
    }
    
    func followCompany(companyIndex: Int) {
        if !companyViewModelList.isEmpty && companyViewModelList.indices.contains(companyIndex) {
            companyViewModelList[companyIndex].isFollowing = !companyViewModelList[companyIndex].isFollowing
            companyViewPresenterViewDelegate?.reloadData()
        }
    }
}
