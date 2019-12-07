//
//  CompanyWebService.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 03/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation

protocol CompanyWebServiceInterface {
    func fetchCompanyInfoList(completionWithCompanyListInfo: @escaping (([CompanyInfo]?) -> Void) )
}

class CompanyWebService: CompanyWebServiceInterface {
    
    let webserviceAdapter = WebserviceAdapter()
    
    func fetchCompanyInfoList(completionWithCompanyListInfo: @escaping (([CompanyInfo]?) -> Void) ) {
        webserviceAdapter.getCall(url: Urls.kCompanyUrl, completionWithResponse: { (response, data) in
            
            guard let dataResponse = data else {
                
                completionWithCompanyListInfo(nil)
                return }
            
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let companyList = try decoder.decode([CompanyInfo].self, from:
                    dataResponse)
                
                completionWithCompanyListInfo(companyList)
                
            } catch let parsingError {
                completionWithCompanyListInfo(nil)
            }
            
        }, completionWithError: { (error) in
            
            completionWithCompanyListInfo(nil)
        })
    }
}
