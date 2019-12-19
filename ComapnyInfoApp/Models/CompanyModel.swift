//
//  CompanyModel.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 30/11/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation

struct CompanyList {
    let companyInfoList: [CompanyInfo]
}

struct CompanyInfo: Codable {
 
    let id: String?
    let companyName: String?
    let logo: URL?
    let description: String?
    let website: URL?
    let memberInfoList: [MemberInfo]?
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case companyName = "company"
        case logo
        case description = "about"
        case website
        case memberInfoList = "members"
    }
}

struct MemberInfo: Codable {
    
    let id: String?
    let age: Int?
    struct Name: Codable {
        let first: String?
        let last: String?
    }
    let name: Name?
    let email: String?
    let phone: String?
    
    private enum CodingKeys: String, CodingKey {
           case id = "_id"
           case age
           case email
           case phone
           case name
       }
}



