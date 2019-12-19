//
//  Constants.swift
//  CompanyInfoApp
//
//  Created by Nitesh Kumar Pal on 03/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation
import UIKit

typealias Urls = Constants.Urls
typealias ViewControllers = Constants.ViewControllers
typealias StoryBoards = Constants.StoryBoards

struct Constants {
    
    private init() {}
    
    struct Urls {
        private init() {}
        
        static let kCompanyUrl = "https://next.json-generator.com/api/json/get/Vk-LhK44U"
    }
    
    struct ViewControllers {
        static var kCompanyViewController = "CompanyViewController"
        static var kMemberViewController = "MemberViewController"
    }
    
    struct StoryBoards {
        static let kMain = UIStoryboard(name: "Main", bundle: nil)
    }
}
