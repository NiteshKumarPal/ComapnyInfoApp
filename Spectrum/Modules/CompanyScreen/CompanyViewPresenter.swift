//
//  CompanyViewPresenter.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 03/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation
import UIKit

protocol CompanyViewPresenterViewDelegate: class {
    func reloadData()
}

class CompanyViewPresenter {
    
    let companyWebService: CompanyWebServiceInterface? = CompanyWebService()
    var companyViewModelList = [CompanyViewModel]()
    var searchResult = [CompanyViewModel]()
    var searchResultFiltered = [CompanyViewModel]()
    
    weak var companyViewPresenterViewDelegate: CompanyViewPresenterViewDelegate?
    
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
    
    func getSearchResult(searchText: String) -> [CompanyViewModel]  {
        let filterCompanyViewModelList = companyViewModelList.filter { (companyViewModel) -> Bool in
            return companyViewModel.companyName.lowercased().contains(searchText.lowercased())
        }
        
        return filterCompanyViewModelList
    }
    
    func updateSearchResult(searchText: String) {
        searchResultFiltered = getSearchResult(searchText: searchText)
        companyViewPresenterViewDelegate?.reloadData()
    }
    
    func getCompanyList(isFiltering: Bool) -> [CompanyViewModel] {
        isFiltering ? searchResultFiltered : companyViewModelList
    }
}
