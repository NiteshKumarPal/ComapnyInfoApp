//
//  ViewController.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 29/11/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController, CompanyViewPresenterViewDelegate {
    
    @IBOutlet weak var tableViewCompanyList: UITableView!
    let searchController = UISearchController()
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty || searchController.searchBar.selectedScopeButtonIndex > 0
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var companyViewPresenter = CompanyViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyViewPresenter.companyViewPresenterViewDelegate = self
        
        fetchCompanyInfoData()
        
        title = CompanyPresenterConstants.kTitle
        
        setupSearchBar()
    }
    
    func setupSearchBar() {
        searchController.searchBar.placeholder = CompanyPresenterConstants.kPlaceholderTextcompanyName
        searchController.searchBar.scopeButtonTitles = [CompanyPresenterConstants.kDefault, CompanyPresenterConstants.kAscending, CompanyPresenterConstants.kDescending]
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func fetchCompanyInfoData() {
        view.showBlurEffectLoader()
        
        companyViewPresenter.fetchCompanyInfoData() { [weak self] in
            CommonUtility.mainThread {
                self?.view.removeBlurEffectLoader()
            }
        }
    }
    
    func reloadData() {
        CommonUtility.mainThread { [weak self] in
            self?.tableViewCompanyList.reloadData()
        }
    }
}

extension CompanyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyViewPresenter.getCompanyList(isFiltering: isFiltering).count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyTabelCell.identifier, for: indexPath) as! CompanyTabelCell
        cell.companyViewModel = companyViewPresenter.getCompanyList(isFiltering: isFiltering)[indexPath.row]
        cell.presenter = companyViewPresenter
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memberViewController = StoryBoards.kMain.instantiateViewController(identifier: ViewControllers.kMemberViewController) as MemberViewController
        
        memberViewController.memberViewPresenter.memberViewModelList = companyViewPresenter.getCompanyList(isFiltering: isFiltering)[indexPath.row].memberViewModelList ?? []
        
        self.navigationController?.pushViewController(memberViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}

extension CompanyViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        companyViewPresenter.updateSearchResult(searchText: searchController.searchBar.text ?? "", scopeValue: searchController.searchBar.selectedScopeButtonIndex)
    }
}
