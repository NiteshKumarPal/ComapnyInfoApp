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
    @IBOutlet weak var imageViewFollow: UIImageView!
    @IBOutlet weak var viewFollow: UIView!
    
    weak var presenter: CompanyViewPresenter?
    
    static let identifier = "CompanyTabelCell"
    
    var companyViewModel: CompanyViewModel? {
        didSet {
            guard let companyViewModel = companyViewModel else { return }
            
            labelFollow.text = companyViewModel.followingText
            imageViewFollow.image = companyViewModel.followImage
            labelCompanyName.text = companyViewModel.companyName
            labelCompanyDescription.text = companyViewModel.description
            imageViewCompanyLogo.loadImage(url: companyViewModel.logo)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        viewFollow.addGestureRecognizer(tap)
    }
    
    @objc func tapAction(_ sender: UITapGestureRecognizer? = nil) {
        if let companyViewModel = companyViewModel {
            companyViewModel.isFollowing = !companyViewModel.isFollowing
            presenter?.companyViewPresenterViewDelegate?.reloadData()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
