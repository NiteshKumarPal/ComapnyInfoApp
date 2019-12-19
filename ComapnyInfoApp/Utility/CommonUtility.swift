//
//  CommonUtility.swift
//  CompanyInfoApp
//
//  Created by Nitesh Kumar Pal on 06/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation

class CommonUtility {
    static func mainThread(completion: @escaping (()-> Void)) {
        DispatchQueue.main.async {
            completion()
        }
    }
}
