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
    
    var presenter = CompanyViewPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.companyViewPresenterViewDelegate = self
        presenter.fetchCompanyInfoData()
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableViewCompanyList.reloadData()
        }
    }
}

extension CompanyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.companyViewModelList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyTabelCell.identifier, for: indexPath) as! CompanyTabelCell
        cell.companyViewModel = presenter.companyViewModelList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memberViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MemberViewController") as MemberViewController
        
        memberViewController.memberViewPresenter.memberInfoList = presenter.companyViewModelList[indexPath.row].memberViewModelList ?? []
        
        self.navigationController?.pushViewController(memberViewController, animated: true)
    }
}
