//
//  LoaderUtility.swift
//  CompanyInfoApp
//
//  Created by Nitesh Kumar Pal on 06/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func showBlurEffectLoader() {
        let blurLoader = BlurEffectLoader(frame: frame)
        self.addSubview(blurLoader)
    }

    func removeBlurEffectLoader() {
        if let blurLoader = subviews.first(where: { $0 is BlurEffectLoader }) {
            blurLoader.removeFromSuperview()
        }
    }
}


class BlurEffectLoader: UIView {

    var blurEffectView: UIVisualEffectView?

    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .systemMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView = blurEffectView
        super.init(frame: frame)
        addSubview(blurEffectView)
        addLoader()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLoader() {
        guard let blurEffectView = blurEffectView else { return }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.startAnimating()
    }
}
