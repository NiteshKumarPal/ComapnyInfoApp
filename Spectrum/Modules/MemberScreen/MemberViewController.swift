//
//  MemberViewController.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 03/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import UIKit

class MemberViewController: UIViewController, MemberViewPresenterViewDelegate {
    
    @IBOutlet weak var tableViewMemberList: UITableView!
    
    var memberViewPresenter = MemberViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberViewPresenter.memberViewPresenterViewDelegate = self
        navigationBarUISetup()
        reloadData()
    }
    
    func navigationBarUISetup() {
        title = memberViewPresenter.title
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.searchController = UISearchController()
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func reloadData() {
        CommonUtility.mainThread { [weak self] in
            self?.tableViewMemberList.reloadData()
        }
    }
}

extension MemberViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberViewPresenter.memberInfoList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberTableViewCell.identifier, for: indexPath) as! MemberTableViewCell
        cell.memberViewModel = memberViewPresenter.memberInfoList[indexPath.row]
        cell.presenter = memberViewPresenter
        return cell
    }
}
