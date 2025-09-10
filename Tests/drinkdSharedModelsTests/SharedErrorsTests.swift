//
//  Test.swift
//  drinkdSharedModels
//
//  Created by Enzo Herrera on 9/9/25.
//

import Testing
@testable import drinkdSharedModels

struct SharedErrorsTests {

    @Test("errorDescription for SharedErrors", arguments: [
        SharedErrors.supabase(error: .dataNotFound),
        SharedErrors.general(error: .generalError("General Error")),
        SharedErrors.internalServerError(error: "Server Error")
    ])
    func errorDescription_Test(sharedError: SharedErrors) async throws {
        switch sharedError {
        case .supabase(let error):
            let description = sharedError.errorDescription
            #expect(description == error.rawValue)
        case .general(_):
            let description = sharedError.errorDescription
            #expect(description == "general error - General Error")
        case .internalServerError(_):
            let description = sharedError.errorDescription
            #expect(description == "Server Error")
        }
    }

    @Test("errorDescription for SharedErrors.General", arguments: [
        SharedErrors.General.missingValue("Missing Value"),
        SharedErrors.General.castingError("Casting Error"),
        SharedErrors.General.generalError("General Error")
    ])
    func general_errorDescription_Test(general: SharedErrors.General) async throws {
        switch general {
        case .missingValue(_):
            let description = general.errorDescription
            #expect(description == "missingValue error - Missing Value")
        case .castingError(_):
            let description = general.errorDescription
            #expect(description == "casting error - Casting Error")
        case .generalError(_):
            let description = general.errorDescription
            #expect(description == "general error - General Error")
        }
    }

}
