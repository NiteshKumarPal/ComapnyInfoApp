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
      return searchController.isActive && !isSearchBarEmpty
    }
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var companyViewPresenter = CompanyViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyViewPresenter.companyViewPresenterViewDelegate = self
        
        fetchCompanyInfoData()
        title = CompanyPresenterConstants.title
        
        searchController.searchBar.placeholder = "Search by company name"
        searchController.searchBar.scopeButtonTitles = ["Ascending", "Descending"]
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
      
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
        
        memberViewController.memberViewPresenter.memberInfoList = companyViewPresenter.getCompanyList(isFiltering: isFiltering)[indexPath.row].memberViewModelList ?? []
        
        self.navigationController?.pushViewController(memberViewController, animated: true)
    }
}

extension CompanyViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    print(searchBar)
  }
}

extension CompanyViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        companyViewPresenter.updateSearchResult(searchText: searchController.searchBar.text ?? "")
    }
}
