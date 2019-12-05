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
    @IBOutlet weak var imageFavorite: UIImageView!
    @IBOutlet weak var viewFollow: UIView!
    
    @IBOutlet weak var viewFavorite: UIView!
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
            imageFavorite.image = companyViewModel.favoriteImage
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapOnFollow = UITapGestureRecognizer(target: self, action: #selector(self.tapActionOnFollow(_:)))
        viewFollow.addGestureRecognizer(tapOnFollow)
        
        let tapOnFavorite = UITapGestureRecognizer(target: self, action: #selector(self.tapActionOnFavorite))
        viewFavorite.addGestureRecognizer(tapOnFavorite)
    }
    
    @objc func tapActionOnFollow(_ sender: UITapGestureRecognizer? = nil) {
        guard let companyViewModel = companyViewModel else { return }
        companyViewModel.isFollowing = !companyViewModel.isFollowing
        presenter?.companyViewPresenterViewDelegate?.reloadData()
    }
    
    @objc func tapActionOnFavorite(_ sender: UITapGestureRecognizer? = nil) {
        guard let companyViewModel = companyViewModel else { return }
        companyViewModel.isFavorite = !companyViewModel.isFavorite
        presenter?.companyViewPresenterViewDelegate?.reloadData()
    }
}
