//
//  WebserviceAdapter.swift
//  Spectrum
//
//  Created by Nitesh Kumar Pal on 03/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import Foundation

class WebserviceAdapter {

    func getCall(url: String,
                 completionWithResponse: @escaping ((Any?, Data?) -> Void),
                 completionWithError: @escaping ((Error?) -> Void)) {
        
        guard let validUrl = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: validUrl) { (data, response, error) in
            
            guard let dataResponse = data,
                error == nil else {
                    
                    completionWithError(error)
                    return }
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                completionWithResponse(jsonResponse, dataResponse)
                
            } catch let parsingError {
                completionWithError(parsingError)
            }
            
        }
        task.resume()
    }
}
