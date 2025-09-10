//
//  Test.swift
//  drinkdSharedModels
//
//  Created by Enzo Herrera on 9/10/25.
//

import Testing
@testable import drinkdSharedModels

struct ErrorWrapperTests {

    @Test("initialization with SharedErrors.SupaBase", arguments: [
        SharedErrors.SupaBase.invalidPartyCode,
        SharedErrors.SupaBase.partyLeaderCannotJoinAParty ,
        SharedErrors.SupaBase.userIsAlreadyInAParty ,
        SharedErrors.SupaBase.userIsAlreadyAPartyLeader,
        SharedErrors.SupaBase.rowIsEmpty ,
        SharedErrors.SupaBase.dataNotFound ,
    ])
    func initialization_Test(errorType: SharedErrors.SupaBase) {

        switch errorType {

        case .invalidPartyCode:
            let inputError = SharedErrors.SupaBase.invalidPartyCode
            let wrapper = ErrorWrapper(errorType: inputError)

            if case .supabase(let supabaseErr) = wrapper.error {
                if case .invalidPartyCode = supabaseErr {
                    // Success - correct mapping
                } else {
                    Issue.record("Expected invalidPartyCode, got \(supabaseErr)")
                }
            } else {
                Issue.record("Expected supabase error, got \(wrapper.error)")
            }

        case .partyLeaderCannotJoinAParty:
            let inputError = SharedErrors.SupaBase.partyLeaderCannotJoinAParty
            let wrapper = ErrorWrapper(errorType: inputError)

            if case .supabase(let supabaseErr) = wrapper.error {
                if case .partyLeaderCannotJoinAParty = supabaseErr {
                    // Success - correct mapping
                } else {
                    Issue.record("Expected partyLeaderCannotJoinAParty, got \(supabaseErr)")
                }
            } else {
                Issue.record("Expected supabase error, got \(wrapper.error)")
            }
        case .userIsAlreadyInAParty:
            let inputError = SharedErrors.SupaBase.userIsAlreadyInAParty
            let wrapper = ErrorWrapper(errorType: inputError)

            if case .supabase(let supabaseErr) = wrapper.error {
                if case .userIsAlreadyInAParty = supabaseErr {
                    // Success - correct mapping
                } else {
                    Issue.record("Expected userIsAlreadyInAParty, got \(supabaseErr)")
                }
            } else {
                Issue.record("Expected supabase error, got \(wrapper.error)")
            }
        case .rowIsEmpty:
            let inputError = SharedErrors.SupaBase.rowIsEmpty
            let wrapper = ErrorWrapper(errorType: inputError)

            if case .supabase(let supabaseErr) = wrapper.error {
                if case .rowIsEmpty = supabaseErr {
                    // Success - correct mapping
                } else {
                    Issue.record("Expected rowIsEmpty, got \(supabaseErr)")
                }
            } else {
                Issue.record("Expected supabase error, got \(wrapper.error)")
            }
        case .dataNotFound:
            let inputError = SharedErrors.SupaBase.dataNotFound
            let wrapper = ErrorWrapper(errorType: inputError)

            if case .supabase(let supabaseErr) = wrapper.error {
                if case .dataNotFound = supabaseErr {
                    // Success - correct mapping
                } else {
                    Issue.record("Expected dataNotFound, got \(supabaseErr)")
                }
            } else {
                Issue.record("Expected supabase error, got \(wrapper.error)")
            }
        case .userIsAlreadyAPartyLeader:
            let inputError = SharedErrors.SupaBase.userIsAlreadyAPartyLeader
            let wrapper = ErrorWrapper(errorType: inputError)

            if case .supabase(let supabaseErr) = wrapper.error {
                if case .userIsAlreadyAPartyLeader = supabaseErr {
                    // Success - correct mapping
                } else {
                    Issue.record("Expected userIsAlreadyAPartyLeader, got \(supabaseErr)")
                }
            } else {
                Issue.record("Expected supabase error, got \(wrapper.error)")
            }
        }



    }

}
