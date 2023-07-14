//
//  AppColor.swift
//  
//
//  Created by Ankit Nigam on 29/06/23.
//

import XCTest
@testable import MyAppColorKit

final class AppColorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMoodColorIfGood() {
        
        XCTAssertEqual(MyAppColor().moodColor(true), UIColor.blue)
    }
    
//    func testMoodColorIfNotGood() {
//        
//        XCTAssertEqual(MyAppColor().moodColor(false), UIColor.red)
//    }

}
