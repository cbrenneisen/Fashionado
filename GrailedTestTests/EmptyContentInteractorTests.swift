//
//  GrailedTestTests.swift
//  GrailedTestTests
//
//  Created by Cbrenneisen on 1/15/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import GrailedTest

/**
    Test that an Interactor with an Empty Service class behaves as expected
*/
final class ContentInteractorTests: XCTestCase {

    typealias T = Article
    typealias Empty = EmptyContentService<Article>
    
    var service: Empty!
    var interactor: ContentInteractor<T, Empty>!
    
    override func setUp() {
        super.setUp()
        
        // inject service that always returns empty data
        self.service = EmptyContentService<T>()
        self.interactor = ContentInteractor<T, Empty>(service: service)
    }
    
    /**
        Leave interactor alone and ensure that defaults are valid
    */
    func testInitialState() {
        // Note: this depends on how fast the intial fetch takes and thus should be fixed
        XCTAssertTrue(interactor.finished.value, "The interactor should NOT be finished yet")
    }

    /**
        Trigger another fetch and ensure interactor is still valid
    */
    func testEmpty() {
        interactor.fetch()
        
        // verify that interactor does not show any content
        let result = interactor.content.asObservable().take(2).toBlockingArray()
        result.forEach() {
            XCTAssertTrue($0.isEmpty, "No results should be displayed")
        }
        XCTAssertTrue(interactor.finished.value, "The interactor should be finished")
    }
}
