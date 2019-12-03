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

//func getParsedModel() {
//    let jsonData = Data(getJsonData().utf8)
//    let decoder = JSONDecoder()
//    decoder.keyDecodingStrategy = .convertFromSnakeCase
//    do {
//     let response = try decoder.decode(CompanyList.self, from: jsonData)
//     print(response)
//    } catch {
//        print("Parsing Failed”)
//    }
//}

func fetchCompanyInfoList(completionWithCompanyListInfo: @escaping (([CompanyInfo]?) -> Void) ) {
    
   guard let url = URL(string: "https://next.json-generator.com/api/json/get/Vk-LhK44U") else {return}
   let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
   guard let dataResponse = data,
             error == nil else {
             print(error?.localizedDescription ?? "Response Error")
             return }
       do{
           //here dataResponse received from a network request
           let jsonResponse = try JSONSerialization.jsonObject(with:
                                  dataResponse, options: [])
           print(jsonResponse) //Response result
        
        //here dataResponse received from a network request
        let decoder = JSONDecoder()
        let companyList = try decoder.decode([CompanyInfo].self, from:
                     dataResponse) //Decode JSON Response Data
        print(companyList)
        
        completionWithCompanyListInfo(companyList)
        
        } catch let parsingError {
           print("Error", parsingError)
            completionWithCompanyListInfo(nil)
      }
   }
   task.resume()
}

