//
//  CompanyInfoAppTests.swift
//  CompanyInfoAppTests
//
//  Created by Nitesh Kumar Pal on 22/12/19.
//  Copyright © 2019 Pioneer. All rights reserved.
//

import XCTest
@testable import CompanyInfoApp

class CompanyInfoAppTests: XCTestCase {

    var companyViewPresenter: CompanyViewPresenter?
    
    override func setUp() {
        companyViewPresenter = CompanyViewPresenter()
        companyViewPresenter?.companyWebService = CompanyWebServiceMock()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNotNilCheck() {
        XCTAssert(companyViewPresenter != nil)
    }
    
    func testFetchCompanyInfoList() {
        
        XCTAssert(companyViewPresenter?.companyWebService != nil)
        
        companyViewPresenter?.companyWebService?.fetchCompanyInfoList { (companyInfoList) in
            XCTAssert(companyInfoList != nil)
            XCTAssert(companyInfoList!.count > 0)
        }
    }
    
    func testGetCompanyViewModelFrom() {
        
        XCTAssert(companyViewPresenter?.companyWebService != nil)
        
        companyViewPresenter?.companyWebService?.fetchCompanyInfoList { [weak self] (companyInfoList) in
            
            guard let selfInstance = self else { return }
            
            let companyViewModelList = selfInstance.companyViewPresenter?.getCompanyViewModelFrom(companyInfoList: companyInfoList) ?? []
            
            XCTAssert(companyViewModelList[0].companyName == "GYNKO")
            XCTAssert(companyViewModelList[0].description == "Veniam sit ex ex esse pariatur proident non aute sunt. Aute id eiusmod aute incididunt sint est ullamco eiusmod adipisicing aliqua est. Velit aliqua occaecat enim pariatur laboris deserunt aliqua dolore fugiat dolor consequat sit occaecat pariatur. Ullamco velit laborum cillum reprehenderit Lorem magna exercitation laboris qui et aute nulla veniam. Reprehenderit nulla culpa elit ad ex ex sunt nisi eiusmod. Non officia ea est exercitation ut Lorem aute nulla.")
            XCTAssert(companyViewModelList[0].logo?.absoluteString == "http://placehold.it/32x32")
            XCTAssert(companyViewModelList[0].memberViewModelList != nil)
            XCTAssert(companyViewModelList[0].memberViewModelList![0].name == "Heather Russell")
            XCTAssert(companyViewModelList[0].memberViewModelList!.count == 5)
            XCTAssert(companyViewModelList[0].id == "5c5bb5ce54a9c166bf1c5b82")
        }
    }
    
    func testGetMemberViewModelListFrom() {
        
        XCTAssert(companyViewPresenter?.companyWebService != nil)
        
        companyViewPresenter?.companyWebService?.fetchCompanyInfoList { [weak self] (companyInfoList) in
            
            guard let selfInstance = self else { return }
            
            let companyViewModelList = selfInstance.companyViewPresenter?.getCompanyViewModelFrom(companyInfoList: companyInfoList) ?? []
            
            XCTAssert(companyViewModelList[0].memberViewModelList != nil)
            XCTAssert(companyViewModelList[0].memberViewModelList![0].name == "Heather Russell")
            XCTAssert(companyViewModelList[0].memberViewModelList![0].age == "26")
            XCTAssert(companyViewModelList[0].memberViewModelList![0].email == "heather.russell@undefined.info")
            XCTAssert(companyViewModelList[0].memberViewModelList![0].id == "5c5bb5ce9ea1ae34c3d4f0c7")
            XCTAssert(companyViewModelList[0].memberViewModelList![0].phone == "+1 (827) 549-3643")
        }
    }
}

class CompanyWebServiceMock:  CompanyWebServiceInterface {
    func fetchCompanyInfoList(completionWithCompanyListInfo: @escaping (([CompanyInfo]?) -> Void)) {
        let data = jsonData(filename: "data")
        
        guard  let dataResponse = data else {
            return
        }
        
        let decoder = JSONDecoder()
        guard let companyList = try? decoder.decode([CompanyInfo].self, from:
            dataResponse) else {
            completionWithCompanyListInfo(nil)
                return
        }
                       
        completionWithCompanyListInfo(companyList)
    }
    
    func jsonData(filename fileName: String) -> Data? {
        if let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            
            return data
        }
        return nil
    }
}
