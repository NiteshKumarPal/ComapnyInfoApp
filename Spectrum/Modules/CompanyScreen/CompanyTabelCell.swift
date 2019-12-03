//
//  CompanyTabelCell.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 30/11/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import UIKit

class CompanyTabelCell: UITableViewCell {

    @IBOutlet weak var imageViewCompanyLogo: UIImageView!
    @IBOutlet weak var labelCompanyName: UILabel!
    @IBOutlet weak var labelCompanyDescription: UILabel!
    @IBOutlet weak var labelFollow: UILabel!
    
    static let identifier = "CompanyTabelCell"
    
    var companyViewModel: CompanyViewModel? {
        didSet {
            //imageViewCompanyLogo.image =
            labelFollow.text = "following"
            labelCompanyName.text = companyViewModel?.companyName
            labelCompanyDescription.text = companyViewModel?.description
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
