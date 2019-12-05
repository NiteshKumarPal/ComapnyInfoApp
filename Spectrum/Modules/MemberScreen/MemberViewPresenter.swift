//
//  MemberViewPresenter.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 03/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation

protocol MemberViewPresenterViewDelegate: class {
    func reloadData()
}

class MemberViewPresenter {
    var memberInfoList = [MemberViewModel]()
    weak var memberViewPresenterViewDelegate: MemberViewPresenterViewDelegate?
    
    let title = "Member list"
}
