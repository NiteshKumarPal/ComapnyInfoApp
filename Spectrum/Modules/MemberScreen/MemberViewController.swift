//
//  MemberViewController.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 03/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import UIKit

class MemberViewController: UIViewController {
    
    @IBOutlet weak var tableViewMemberList: UITableView!
    
    var memberViewPresenter = MemberViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return cell
    }
}
