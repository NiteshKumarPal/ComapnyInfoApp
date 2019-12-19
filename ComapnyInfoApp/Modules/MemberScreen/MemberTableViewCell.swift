//
//  MemberTableViewCell.swift
//  CompanyInfoApp
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
    @IBOutlet weak var labelPhoneNumber: UILabel!
    @IBOutlet weak var viewFavorite: UIView!
    
    static let identifier = "MemberTableViewCell"
    
    var presenter: MemberViewPresenter?
    var memberViewModel: MemberViewModel? {
        didSet {
            
            guard let memberViewModel = memberViewModel else {
                return
            }
            
            labelName.text = memberViewModel.name
            labelAge.text =  memberViewModel.age
            labelEmailId.text = memberViewModel.email
            labelPhoneNumber.text = memberViewModel.phone
            imageFavourateStar.image = memberViewModel.favourateImage
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let favoriteTap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnFavoriteAction))
        viewFavorite.addGestureRecognizer(favoriteTap)
        
        let mailTap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnMailLinkAction))
        labelEmailId.isUserInteractionEnabled = true
        labelEmailId.addGestureRecognizer(mailTap)
        
        let phoneTap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnPhoneAction))
        labelPhoneNumber.isUserInteractionEnabled = true
        labelPhoneNumber.addGestureRecognizer(phoneTap)
        
        setupCardViewEffect()
    }
    
    @objc func tapOnFavoriteAction(_ sender: UITapGestureRecognizer? = nil) {
        guard let memberViewModel = memberViewModel else {
            return
        }
        memberViewModel.isFavorite = !memberViewModel.isFavorite
        presenter?.memberViewPresenterViewDelegate?.reloadData()
    }
    
    @objc func tapOnMailLinkAction(_ sender: UITapGestureRecognizer? = nil) {
        
        guard let memberViewModel = memberViewModel else {
            return
        }
        
        if let url = URL(string: "mailto:\(memberViewModel.email)"),
            UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url)
        }
    }
    
    @objc func tapOnPhoneAction(_ sender: UITapGestureRecognizer? = nil) {
        guard let memberViewModel = memberViewModel else {
            return
        }
        
        if let url = URL(string: "telprompt://\(memberViewModel.phone)"), UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
