//
//  AtomicHabitTests.swift
//  AtomicHabitTests
//
//  Created by Hung-Chun Tsai on 2021-02-27.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import XCTest

@testable import AtomicHabit

class AtomicHabitTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    func testLoginAccountWithAccountDoesntExist() {
        
        var showAlert = false
        var authError: EmailAuthError?
        let email = "asdoifhiohkqwe@gmail.com"
        let password = "123"
        
        let exp = expectation(description: "Email doesn't Exist")

        FBAuth.authenticate(withEmail: email, password: password) { (result) in
            switch result {
                case .failure(let error) :
                    authError = error
                    showAlert = true
                case .success( _):
                    print("Signed in")
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(authError, EmailAuthError.accoundDoesNotExist)
            XCTAssertEqual(showAlert, true)
        }
    }

    func testLoginAccountWithInvalidEmail() {
        
        var showAlert = false
        var authError: EmailAuthError?
        let email = "asdoifhiohkqwe"
        let password = "123"
        let exp = expectation(description: "Login with Invalid Email.")

        FBAuth.authenticate(withEmail: email, password: password) { (result) in
            switch result {
                case .failure(let error) :
                    authError = error
                    showAlert = true
                case .success( _):
                    print("Signed in")
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(authError, EmailAuthError.invalidEmail)
            XCTAssertEqual(showAlert, true)
        }
    }
    
    func testLoginAccountWithWrongPassword() {
        
        var showAlert = false
        var authError: EmailAuthError?
        let email = "tsaihong1995@gmail.com"
        let password = "123"
        let exp = expectation(description: "Login with wrong password.")

        FBAuth.authenticate(withEmail: email, password: password) { (result) in
            switch result {
                case .failure(let error) :
                    authError = error
                    showAlert = true
                case .success( _):
                    print("Signed in")
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(authError, EmailAuthError.incorrectPassword)
            XCTAssertEqual(showAlert, true)
        }
    }
    
    func testRegistrationWithPasswordLessThan6() {
        
        let email = "tsaihong1995@gmail.com"
        let name = "TestAccount"
        let password = "Test"
        let exp = expectation(description: "Account Already Exist")
        var errorString = String()
        var showError = false
        
        FBAuth.createUser(withEmail: email,
                          name: name,
                          password: password) { (result) in
            switch result  {
            case .failure(let error):
                errorString = error.localizedDescription
                showError = true
            case.success( _):
                print("Account creation successful")
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(errorString, "The password must be 6 characters long or more.")
            XCTAssertEqual(showError, true)
        }
    }
    
    func testRegistrationWithExistingAccount() {
        
        let email = "tsaihong1995@gmail.com"
        let name = "TestAccount"
        let password = "TestAccount"
        let exp = expectation(description: "Account Already Exist")
        var errorString = String()
        var showError = false
        
        FBAuth.createUser(withEmail: email,
                          name: name,
                          password: password) { (result) in
            switch result  {
            case .failure(let error):
                errorString = error.localizedDescription
                showError = true
            case.success( _):
                print("Account creation successful")
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(errorString, "The email address is already in use by another account.")
            XCTAssertEqual(showError, true)
        }
    }

    func testRegistrationWithNonExistingAccountAndAccountCreate() {
        
        let email = "tsaihong2000@gmail.com"
        let name = "TestAccount"
        let password = "TestAccount"
        let exp = expectation(description: "Account create")
        var errorString = String()
        var showError = false
        
        FBAuth.createUser(withEmail: email,
                          name: name,
                          password: password) { (result) in
            switch result  {
            case .failure(let error):
                errorString = error.localizedDescription
                showError = true
            case.success( _):
                print("Account creation successful")
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(errorString, "")
            XCTAssertEqual(showError, false)
        }
    }

}
