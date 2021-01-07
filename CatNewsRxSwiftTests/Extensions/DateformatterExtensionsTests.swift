//
//  DateformatterExtensionsTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

@testable import CatNewsRxSwift
import XCTest

class DateformatterExtensionsTests: XCTestCase {

    func testFullDateDateFormatterReturnsDateFormatter() {
        let dateFormatter = DateFormatter.fullDate
        dateFormatter.locale = Locale(identifier: "en_GB")
        let date = Date(timeIntervalSince1970: 1607452233)
        let expectedResult = "Tuesday, 8 December 2020 at 18:30:33"

        let result = dateFormatter.string(from: date)

        XCTAssertEqual(result, expectedResult)
    }

    func testNamedRelativeDateTimeFormatterReturnsRelativeDateTimeFormatter() {
        let dateFormatter = RelativeDateTimeFormatter.named
        dateFormatter.locale = Locale(identifier: "en_GB")
        let date = Date(timeIntervalSince1970: 1607452233)
        let relativeDate = Date(timeIntervalSince1970: 1607455233)

        let expectedResult = "50 min ago"

        let result = dateFormatter.localizedString(for: date, relativeTo: relativeDate)

        XCTAssertEqual(result, expectedResult)
    }

}
