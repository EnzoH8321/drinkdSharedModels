//
//  Test.swift
//  drinkdSharedModels
//
//  Created by Enzo Herrera on 9/9/25.
//

import Testing
import Foundation
@testable import drinkdSharedModels

struct SharedNetworkingTests {

    private let devURL = "http://localhost:8080/"
    private let partyUUID = UUID(uuidString: "123e4567-e89b-12d3-a456-426655440000")!
    private let userID = UUID(uuidString: "341e4567-e83b-12d3-b456-426655440000")!

    #if DEBUG
    // Test fullURLString
    @Test("Test PostRoute fullURLString with the debug baseURLString")
    func postRoutesFullURLString_Debug_Test() async throws {

        let createParty = HTTP.PostRoutes.createParty
        let joinParty = HTTP.PostRoutes.joinParty
        let leaveParty = HTTP.PostRoutes.leaveParty
        let sendMessage = HTTP.PostRoutes.sendMessage
        let updateRating = HTTP.PostRoutes.updateRating

        #expect(createParty.fullURLString == "\(devURL)\(createParty.rawValue)")
        #expect(joinParty.fullURLString == "\(devURL)\(joinParty.rawValue)")
        #expect(leaveParty.fullURLString == "\(devURL)\(leaveParty.rawValue)")
        #expect(sendMessage.fullURLString == "\(devURL)\(sendMessage.rawValue)")
        #expect(updateRating.fullURLString == "\(devURL)\(updateRating.rawValue)")
    }

    @Test("Test GetRoute fullURLString with the debug baseURLString")
    func getRoutesFullURLString_Debug_Test() async throws {

        let topRestaurants = HTTP.GetRoutes.topRestaurants
        let rejoinParty = HTTP.GetRoutes.rejoinParty
        let getMessages = HTTP.GetRoutes.getMessages
        let ratedRestaurants = HTTP.GetRoutes.ratedRestaurants

        #expect(topRestaurants.fullURLString == "\(devURL)\(topRestaurants.rawValue)")
        #expect(rejoinParty.fullURLString == "\(devURL)\(rejoinParty.rawValue)")
        #expect(getMessages.fullURLString == "\(devURL)\(getMessages.rawValue)")
        #expect(ratedRestaurants.fullURLString == "\(devURL)\(ratedRestaurants.rawValue)")
    }
    // Test GetReq createReq
    @Test("Test GetReq.createReq for topRestaurants in debug")
    func getReq_createReq_topRestaurants_Debug_Test() throws {

        let rawVal = HTTP.GetRoutes.topRestaurants.rawValue
        let urlString = "\(devURL)\(rawVal)?partyID=\(partyUUID.uuidString)"
        let req = try HTTP.GetReq.topRestaurants(partyID: partyUUID).createReq()

        #expect(req.httpMethod == "GET")
        #expect(req.url?.absoluteString == urlString)
    }

    @Test("Test GetReq.createReq for rejoinParty in debug")
    func getReq_createReq_rejoinParty_Debug_Test() throws {

        let rawVal = HTTP.GetRoutes.rejoinParty.rawValue
        let rejoinPartyURLString = "\(devURL)\(rawVal)?userID=\(userID)"
        let rejoinPartyReq = try HTTP.GetReq.rejoinParty(userID: userID.uuidString).createReq()

        #expect(rejoinPartyReq.httpMethod == "GET")
        #expect(rejoinPartyReq.url?.absoluteString == rejoinPartyURLString)
    }

    @Test("Test GetReq.createReq for getMessages in debug")
    func getReq_createReq_getMessages_Debug_Test() throws {

        let getMessagesRawVal = HTTP.GetRoutes.getMessages.rawValue
        let getMessagesURLString = "\(devURL)\(getMessagesRawVal)?partyID=\(partyUUID.uuidString)"
        let getMessagesPartyReq = try HTTP.GetReq.getMessages(partyID: partyUUID).createReq()

        #expect(getMessagesPartyReq.httpMethod == "GET")
        #expect(getMessagesPartyReq.url?.absoluteString == getMessagesURLString)
    }

    @Test("Test GetReq.createReq for ratedRestaurants in debug")
    func getReq_createReq_ratedRestaurants_Debug_Test() throws {

        let ratedRestaurantsRawVal = HTTP.GetRoutes.ratedRestaurants.rawValue
        let ratedRestaurantsURLString = "\(devURL)\(ratedRestaurantsRawVal)?userID=\(userID.uuidString)&partyID=\(partyUUID.uuidString)"
        let ratedRestaurantsPartyReq = try HTTP.GetReq.ratedRestaurants(userID: userID, partyID: partyUUID).createReq()

        #expect(ratedRestaurantsPartyReq.httpMethod == "GET")
        #expect(ratedRestaurantsPartyReq.url?.absoluteString == ratedRestaurantsURLString)
    }

   

    // Test GetReq urlComponents
    @Test("Test GetReq.urlComponents for topRestaurants in debug")
    func getReq_urlComponents_topRestaurants_Debug_Test() throws {

        let getReq = HTTP.GetReq.topRestaurants(partyID: partyUUID)
        let components = getReq.urlComponents

        #expect(components.url == HTTP.GetRoutes.topRestaurants.fullURLString)
    }


    #else
    @Test("Test PostRoute fullURLString with the release baseURLString")
    func postRoutesFullURLString_Release_Test() async throws {
        let releaseURL = "https://drinkdvaporserver.fly.dev/"
        let createParty = HTTP.PostRoutes.createParty
        let joinParty = HTTP.PostRoutes.joinParty
        let leaveParty = HTTP.PostRoutes.leaveParty
        let sendMessage = HTTP.PostRoutes.sendMessage
        let updateRating = HTTP.PostRoutes.updateRating
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        #expect(createParty.fullURLString == "\(releaseURL)\(createParty.rawValue)")
        #expect(joinParty.fullURLString == "\(releaseURL)\(joinParty.rawValue)")
        #expect(leaveParty.fullURLString == "\(releaseURL)\(leaveParty.rawValue)")
        #expect(sendMessage.fullURLString == "\(releaseURL)\(sendMessage.rawValue)")
        #expect(updateRating.fullURLString == "\(releaseURL)\(updateRating.rawValue)")
    }
    #endif
}
