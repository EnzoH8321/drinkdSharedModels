//
//  Test.swift
//  drinkdSharedModels
//
//  Created by Enzo Herrera on 9/10/25.
//

import Testing
import Foundation

struct ExtensionsTests {

    let dateString = "2025-09-10T16:25:59+00:00"

    @Test("fromPostgreSQLTimestamp")
    func fromPostgreSQLTimestamp_Test() async throws {
        let date = dateString.fromPostgreSQLTimestamp()!
        #expect(date.timeIntervalSince1970 == 1757521559.0)
    }

    @Test("monthDay")
    func monthDay_Test() async throws {
        // Converts to "2025-09-10T16:25:59+00:00"
        let date = Date(timeIntervalSince1970: 1757521559.0)
        let monthDay = date.monthDay

        #expect(monthDay == "09/10")
    }

}
