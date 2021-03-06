//
//  SwiftAddressBookTests.swift
//  SwiftAddressBookTests
//
//  Created by Albert Bori on 2/23/15.
//  Copyright (c) 2015 socialbit. All rights reserved.
//

import UIKit
import XCTest
import SwiftAddressBook
import AddressBook

//**** Run the example project first, to accept address book access ****
class SwiftAddressBookTests: XCTestCase {

	let waitTime = 3.0
    
    let accessError = "Address book access was not granted. Run the main application and grant access to the address book."
    let accessErrorNil = "Failed to get address book access denial error"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	//TODO: test authorization status, save, revert
    
    func testGetAllPeople() {

		let testExpectation = expectationWithDescription("testGetAllPeople")

        swiftAddressBook?.requestAccessWithCompletion({ (success, error) -> Void in
            XCTAssertTrue(success, self.accessError)
            if success {
                let people : Array<SwiftAddressBookPerson>? = swiftAddressBook?.allPeople
                
                XCTAssert(people?.count > 0, "Unable to get people from address book")
            } else {
                XCTAssertNotNil(error, self.accessErrorNil)
			}
			
			testExpectation.fulfill()
		})

		waitForExpectationsWithTimeout(waitTime, handler: nil)
    }
    
	//TODO: tests badly: actually only checks that array is not empty, instead of if linked contacts contained
	func testGetAllPeopleExcludingLinkedContacts() {
		let testExpectation = expectationWithDescription("testGetAllPeople")

		swiftAddressBook?.requestAccessWithCompletion({ (success, error) -> Void in
			XCTAssertTrue(success, self.accessError)
			if success {
				let people : Array<SwiftAddressBookPerson>? = swiftAddressBook?.allPeopleExcludingLinkedContacts

				XCTAssert(people?.count > 0, "Unable to get main contacts from address book")

			} else {
				XCTAssertNotNil(error, self.accessErrorNil)
			}

			testExpectation.fulfill()
		})

		waitForExpectationsWithTimeout(waitTime, handler: nil)
	}


    //MARK: - Helper funtions

    func getDateTimestamp() -> String {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        return formatter.stringFromDate(NSDate())
    }
    
    func getDate(year: Int,_ month: Int,_ day: Int) -> NSDate {
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
}
