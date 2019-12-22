//
//  MemberViewController.swift
//  CompanyInfoApp
//
//  Created by Nitesh Kumar Pal on 03/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import UIKit

class MemberViewController: UIViewController, MemberViewPresenterViewDelegate {
    
    @IBOutlet weak var labelCompanyName: UILabel!
    @IBOutlet weak var tableViewMemberList: UITableView!
    private let searchController = UISearchController()
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty || searchController.searchBar.selectedScopeButtonIndex > 0
    }
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    let memberViewPresenter = MemberViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberViewPresenter.memberViewPresenterViewDelegate = self
        navigationBarUISetup()
        setupTableView()
        reloadData()
    }
    
    func navigationBarUISetup() {
        title = MemberViewPresenterConstants.kTitle
        navigationItem.largeTitleDisplayMode = .never
        setupSearchBar()
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func setupSearchBar() {
        searchController.searchBar.placeholder = MemberViewPresenterConstants.kPlaceholderTextMemberName
        searchController.searchBar.scopeButtonTitles =
            [MemberViewPresenterConstants.kDefault,
             MemberViewPresenterConstants.kNameUp,
             MemberViewPresenterConstants.kNameDown,
             MemberViewPresenterConstants.kAgeUp,
             MemberViewPresenterConstants.kAgeDown]
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func setupTableView() {
        labelCompanyName.attributedText = memberViewPresenter.getCompanyInfo()
        tableViewMemberList.tableFooterView = UIView()
        tableViewMemberList.separatorStyle = .none
    }
    
    func reloadData() {
        CommonUtility.mainThread { [weak self] in
            self?.tableViewMemberList.reloadData()
        }
    }
}

extension MemberViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberViewPresenter.getMemberList(isFiltering: isFiltering).count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberTableViewCell.identifier, for: indexPath) as! MemberTableViewCell
        cell.memberViewModel = memberViewPresenter.getMemberList(isFiltering: isFiltering)[indexPath.row]
        cell.presenter = memberViewPresenter
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}

extension MemberViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        memberViewPresenter.updateSearchResult(searchText: searchController.searchBar.text ?? "", scopeValue: searchController.searchBar.selectedScopeButtonIndex)
    }
}
