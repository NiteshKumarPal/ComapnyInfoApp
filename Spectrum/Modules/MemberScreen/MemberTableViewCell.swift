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
    
    var memberInfo: MemberInfo! {
        didSet {
            labelName.text = "\(memberInfo?.name?.first ?? "") \(memberInfo?.name?.last ?? "")"
            labelAge.text =  String(memberInfo?.age ?? 0)
            labelEmailId.text = memberInfo?.email ?? ""
            lablePhoneNumber.text = memberInfo?.phone ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
