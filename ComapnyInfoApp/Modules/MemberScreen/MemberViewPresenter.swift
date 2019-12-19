//
//  MemberViewPresenter.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 03/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation
import UIKit

protocol MemberViewPresenterViewDelegate: class {
    func reloadData()
}

extension MemberViewPresenter {
    enum MemberResultSortType: Int {
        case defaultCase
        case nameAscending
        case nameDescending
        case ageAscending
        case ageDescending
    }
}

class MemberViewPresenter {
    var companyViewModel: CompanyViewModel? {
        didSet {
            guard let companyViewModel = companyViewModel  else  { return }
            memberViewModelList = companyViewModel.memberViewModelList ?? []
        }
    }
    
    var memberViewModelList = [MemberViewModel]()
    var searchResultFiltered = [MemberViewModel]()
    weak var memberViewPresenterViewDelegate: MemberViewPresenterViewDelegate?
    
    func getCompanyInfo() -> NSAttributedString {
        let companyInfo =  NSMutableAttributedString()
    
        let companyNameLabel = NSAttributedString(string: "Company name: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        
        guard let companyViewModel = companyViewModel else {
            return companyNameLabel
        }
        
        let companyName = NSAttributedString(string: companyViewModel.companyName, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        
        companyInfo.append(companyNameLabel)
        companyInfo.append(companyName)
        
        return companyInfo
    }
    
    func getSearchResult(searchText: String) -> [MemberViewModel]  {
        let filteredMemberViewModel = memberViewModelList.filter { (memberViewModel) -> Bool in
            return memberViewModel.name.lowercased().contains(searchText.lowercased())
        }
        
        return filteredMemberViewModel
    }
    
    func updateSearchResult(searchText: String, scopeValue: Int = 0) {
        searchResultFiltered = getSearchResult(searchText: searchText)
        let modelList = searchText.isEmpty ? memberViewModelList : searchResultFiltered
        searchResultFiltered = sortTheResultWith(modelList: modelList, scopeValue: scopeValue)
        memberViewPresenterViewDelegate?.reloadData()
    }
    
    func getMemberList(isFiltering: Bool) -> [MemberViewModel] {
        isFiltering ? searchResultFiltered : memberViewModelList
    }
    
    func sortTheResultWith(modelList: [MemberViewModel], scopeValue: Int) -> [MemberViewModel]  {
        let sortType = MemberResultSortType(rawValue: scopeValue)
        
        var sotedMemberViewModelList = [MemberViewModel]()
        
        switch sortType {
        case .defaultCase, .none:
            sotedMemberViewModelList = modelList
        case .nameAscending:
            sotedMemberViewModelList = modelList.sorted(by: { (memberViewModelFirst, memberViewModelSecond) -> Bool in
                memberViewModelFirst.name < memberViewModelSecond.name
            })
        case .nameDescending:
            sotedMemberViewModelList = modelList.sorted(by: { (memberViewModelFirst, memberViewModelSecond) -> Bool in
                
                memberViewModelFirst.name > memberViewModelSecond.name
            })
            
        case .ageAscending:
            sotedMemberViewModelList = modelList.sorted(by: { (memberViewModelFirst, memberViewModelSecond) -> Bool in
                
                memberViewModelFirst.age < memberViewModelSecond.age
            })
        case .ageDescending:
            sotedMemberViewModelList = modelList.sorted(by: { (memberViewModelFirst, memberViewModelSecond) -> Bool in
                
                memberViewModelFirst.age > memberViewModelSecond.age
            })
        }
        
        return sotedMemberViewModelList
    }
}
