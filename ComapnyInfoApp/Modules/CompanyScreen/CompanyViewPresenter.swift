//
//  CompanyViewPresenter.swift
//  CompanyInfoApp
//
//  Created by Nitesh Kumar Pal on 03/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation
import UIKit

protocol CompanyViewPresenterViewDelegate: class {
    func reloadData()
}

extension CompanyViewPresenter {
    enum ComapnyResultSortType: Int {
        case defaultCase
        case ascendng
        case descending
    }
}

class CompanyViewPresenter {
    
    let companyWebService: CompanyWebServiceInterface? = CompanyWebService()
    var companyViewModelList = [CompanyViewModel]()
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
    
    func updateSearchResult(searchText: String, scopeValue: Int) {
        searchResultFiltered = getSearchResult(searchText: searchText)
        let modelList = searchText.isEmpty ? companyViewModelList : searchResultFiltered
        searchResultFiltered = sortTheResultWith(modelList: modelList, scopeValue: scopeValue)
        companyViewPresenterViewDelegate?.reloadData()
    }
    
    func getCompanyList(isFiltering: Bool) -> [CompanyViewModel] {
        isFiltering ? searchResultFiltered : companyViewModelList
    }
    
    func sortTheResultWith(modelList: [CompanyViewModel], scopeValue: Int) -> [CompanyViewModel]  {
        let sortType = ComapnyResultSortType(rawValue: scopeValue)
        
        var sortedCompanyViewModelList = [CompanyViewModel]()
        
        switch sortType {
        case .defaultCase, .none:
            sortedCompanyViewModelList = modelList
        case .ascendng:
            sortedCompanyViewModelList = modelList.sorted(by: { (companyViewModelFirst, companyViewModelSecond) -> Bool in
                
                companyViewModelFirst.companyName < companyViewModelSecond.companyName
            })
        case .descending:
            sortedCompanyViewModelList = modelList.sorted(by: { (companyViewModelFirst, companyViewModelSecond) -> Bool in
                
                companyViewModelFirst.companyName > companyViewModelSecond.companyName
            })
        }
        
        return sortedCompanyViewModelList
    }
}
