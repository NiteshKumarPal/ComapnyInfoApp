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
            lablePhoneNumber.text = memberViewModel.phone
            imageFavourateStar.image = memberViewModel.favourateImage
        }
    }
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
           
           let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
           viewFavorite.addGestureRecognizer(tap)
       }
       
    @objc func tapAction(_ sender: UITapGestureRecognizer? = nil) {
        guard let memberViewModel = memberViewModel else {
            return
        }
        memberViewModel.isFavorite = !memberViewModel.isFavorite
        presenter?.memberViewPresenterViewDelegate?.reloadData()
    }
}
