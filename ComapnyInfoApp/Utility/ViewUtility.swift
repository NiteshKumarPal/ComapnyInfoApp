//
//  ViewUtility.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 07/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func setupCardViewEffect() {
       contentView.layer.borderWidth = 0.5
       contentView.layer.borderColor = UIColor.lightGray.cgColor
       contentView.layer.masksToBounds = true
       layer.shadowColor = UIColor.gray.cgColor
       layer.shadowOffset = CGSize(width: 0, height: 2.0)
       layer.shadowRadius = 2.0
       layer.shadowOpacity = 1.0
       layer.masksToBounds = false
       layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
}

class ViewUtility {
   static func setTitle(title: String, titleColor: UIColor, titleSize: Int, subtitle: String, subtitleColor: UIColor, subtitleSize: Int , view: UIView) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x:0, y:-5, width: view.frame.width - 100, height: 20))

        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = titleColor
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(titleSize))
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textAlignment = .center
        titleLabel.text = title
        
        let subtitleLabel = UILabel(frame: CGRect(x:0, y:18, width: view.frame.width - 100, height: 10))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = subtitleColor
        subtitleLabel.adjustsFontSizeToFitWidth = false
        subtitleLabel.lineBreakMode = .byTruncatingTail
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.systemFont(ofSize: CGFloat(subtitleSize))
        subtitleLabel.text = subtitle
        
        let titleView = UIView(frame: CGRect(x:0, y:0, width: view.frame.width - 30, height:30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)

        return titleView
    }
}
