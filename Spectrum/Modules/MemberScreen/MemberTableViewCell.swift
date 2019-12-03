//
//  MemberTableViewCell.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 03/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var imageFavourateStar: UIImageView!
    @IBOutlet weak var labelEmailId: UILabel!
    @IBOutlet weak var lablePhoneNumber: UILabel!
    
    static let identifier = "MemberTableViewCell"
    
    var memberViewModel: MemberViewModel! {
        didSet {
            labelName.text = memberViewModel.name
            labelAge.text =  memberViewModel.age
            labelEmailId.text = memberViewModel.email
            lablePhoneNumber.text = memberViewModel.phone
        }
    }
}
