//
//  DeveloperAppsTests.swift
//  DeveloperAppsTests
//
//  Created by Dawand Sulaiman on 10/01/2018.
//  Copyright © 2018 Kurdcode. All rights reserved.
//

import XCTest
@testable import DeveloperApps

class DeveloperAppsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetApps() {
        DeveloperApps.getApps(for: "dawand") { (apps, error) in
//            if let error = error {
//                // got an error in getting the data
//                print(error)
//                return
//            }
//            guard let apps = apps else {
//                print("error getting all apps: result is nil")
//                return
//            }
            
//            for app in apps {
//                print(app.name)
//            }
            XCTAssertNotNil(apps)
        }
    }
    
}
