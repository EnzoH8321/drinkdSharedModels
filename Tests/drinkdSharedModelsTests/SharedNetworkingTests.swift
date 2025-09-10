//
//  Test.swift
//  drinkdSharedModels
//
//  Created by Enzo Herrera on 9/9/25.
//

import Testing
import Foundation
@testable import drinkdSharedModels
@Suite("SharedNetworkingTests")
struct SharedNetworkingTests {

    private let devURL = "http://localhost:8080/"
    private static let partyUUID = UUID(uuidString: "123e4567-e89b-12d3-a456-426655440000")!
    private static let userID = UUID(uuidString: "341e4567-e83b-12d3-b456-426655440000")!
    private static let username = "Test007"
    private static let restaurantsURL = "https://api.yelp.com/v3/businesses/search?categories=bars&latitude=37.774292458506686&longitude=-122.21621476154564&limit=10"
    private static let partyName = "TestParty007"
    private static let partyCode = 034992
    private static let messageOne = "Hello World!"
    private static let restaurantName = "TestRestaurant001"
    private static let ratingTwo = 2
    private static let imageURL = "https://s3-media0.fl.yelpcdn.com/bphoto/7ZZWfVWBuAEq0v0AOfOksA/o.jpg"

    #if DEBUG

    @Test("Test PostRoute.fullURLString with the debug baseURLString")
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

    @Test("Test GetRoute.fullURLString with the debug baseURLString")
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


    @Test("Test GetReq.createReq", arguments: [
        HTTP.GetReq.topRestaurants(partyID: SharedNetworkingTests.partyUUID),
        HTTP.GetReq.rejoinParty(userID: SharedNetworkingTests.userID.uuidString),
        HTTP.GetReq.getMessages(partyID: SharedNetworkingTests.partyUUID),
        HTTP.GetReq.ratedRestaurants(userID: SharedNetworkingTests.userID, partyID: SharedNetworkingTests.partyUUID)
    ])
    func getReq_createReq_Debug_Test(getReq: HTTP.GetReq) {

        do {
            switch getReq {

            case .topRestaurants(partyID: let partyID):
                let rawVal = HTTP.GetRoutes.topRestaurants.rawValue
                let urlString = "\(devURL)\(rawVal)?partyID=\(partyID.uuidString)"
                let req = try HTTP.GetReq.topRestaurants(partyID: partyID).createReq()

                #expect(req.httpMethod == "GET")
                #expect(req.url?.absoluteString == urlString)
            case .rejoinParty(userID: let userID):
                let rawVal = HTTP.GetRoutes.rejoinParty.rawValue
                let rejoinPartyURLString = "\(devURL)\(rawVal)?userID=\(userID)"
                let rejoinPartyReq = try HTTP.GetReq.rejoinParty(userID: SharedNetworkingTests.userID.uuidString).createReq()

                #expect(rejoinPartyReq.httpMethod == "GET")
                #expect(rejoinPartyReq.url?.absoluteString == rejoinPartyURLString)
            case .getMessages(partyID: let partyID):
                let getMessagesRawVal = HTTP.GetRoutes.getMessages.rawValue
                let getMessagesURLString = "\(devURL)\(getMessagesRawVal)?partyID=\(partyID.uuidString)"
                let getMessagesPartyReq = try HTTP.GetReq.getMessages(partyID: partyID).createReq()

                #expect(getMessagesPartyReq.httpMethod == "GET")
                #expect(getMessagesPartyReq.url?.absoluteString == getMessagesURLString)
            case .ratedRestaurants(userID: let userID, partyID: let partyID):
                let ratedRestaurantsRawVal = HTTP.GetRoutes.ratedRestaurants.rawValue
                let ratedRestaurantsURLString = "\(devURL)\(ratedRestaurantsRawVal)?userID=\(userID.uuidString)&partyID=\(partyID.uuidString)"
                let ratedRestaurantsPartyReq = try HTTP.GetReq.ratedRestaurants(userID: userID, partyID: partyID).createReq()

                #expect(ratedRestaurantsPartyReq.httpMethod == "GET")
                #expect(ratedRestaurantsPartyReq.url?.absoluteString == ratedRestaurantsURLString)
            }
        } catch {
            Issue.record(error)
        }
    }

    @Test("Test GetReq.urlComponents", arguments: [
        HTTP.GetReq.topRestaurants(partyID: SharedNetworkingTests.partyUUID),
        HTTP.GetReq.rejoinParty(userID: SharedNetworkingTests.userID.uuidString),
        HTTP.GetReq.getMessages(partyID: SharedNetworkingTests.partyUUID),
        HTTP.GetReq.ratedRestaurants(userID: SharedNetworkingTests.userID, partyID: SharedNetworkingTests.partyUUID)
    ])
    func getReq_urlComponents_Debug_Test(_ getReq: HTTP.GetReq) async throws {

        switch getReq {
        case .topRestaurants(let partyID):
            let components = getReq.urlComponents
            #expect(components.url == HTTP.GetRoutes.topRestaurants.fullURLString)
            #expect(components.queryItems == [URLQueryItem(name: "partyID", value: partyID.uuidString)])
        case .rejoinParty(let userID):
            let components = getReq.urlComponents
            #expect(components.url == HTTP.GetRoutes.rejoinParty.fullURLString)
            #expect(components.queryItems == [URLQueryItem(name: "userID", value: userID)])
        case .getMessages(let partyID):
            let components = getReq.urlComponents
            #expect(components.url == HTTP.GetRoutes.getMessages.fullURLString)
            #expect(components.queryItems == [URLQueryItem(name: "partyID", value: partyID.uuidString)])
        case .ratedRestaurants(let userID, let partyID):
            let components = getReq.urlComponents
            #expect(components.url == HTTP.GetRoutes.ratedRestaurants.fullURLString)
            #expect(components.queryItems == [
                URLQueryItem(name: "userID", value: userID.uuidString),
                URLQueryItem(name: "partyID", value: partyID.uuidString)
            ])
        }

    }

    @Test("Test PostReq.createReq", arguments: [
        HTTP.PostReq.createParty(userID: SharedNetworkingTests.userID, userName: SharedNetworkingTests.username, restaurantsUrl: SharedNetworkingTests.restaurantsURL, partyName: SharedNetworkingTests.partyName),
        HTTP.PostReq.joinParty(userID: SharedNetworkingTests.userID, partyCode: SharedNetworkingTests.partyCode, userName: SharedNetworkingTests.username),
        HTTP.PostReq.leaveParty(userID: SharedNetworkingTests.userID),
        HTTP.PostReq.sendMessage(userID: SharedNetworkingTests.userID, username: SharedNetworkingTests.username, message: SharedNetworkingTests.messageOne, partyID: SharedNetworkingTests.partyUUID),
        HTTP.PostReq.updateRating(partyID: SharedNetworkingTests.partyUUID, userName: SharedNetworkingTests.username, userID: SharedNetworkingTests.userID, restaurantName: SharedNetworkingTests.restaurantName, rating: SharedNetworkingTests.ratingTwo, imageuRL: SharedNetworkingTests.imageURL)

    ])
    func postReq_createReq_Debug_Test(_ postReq: HTTP.PostReq) async throws {

        do {
            switch postReq {
            case .createParty(let userID, let userName, let restaurantsUrl, let partyName):
                let req = try postReq.createReq()
                let body = try JSONDecoder().decode(CreatePartyRequest.self, from: req.httpBody!)
                #expect(req.httpMethod == "POST")
                #expect(req.url?.absoluteString == HTTP.PostRoutes.createParty.fullURLString)
                #expect(body.partyName == partyName)
                #expect(body.restaurants_url == restaurantsUrl)
                #expect(body.userID == userID)
                #expect(body.username == userName)
            case .joinParty(let userID, let partyCode, let userName):
                let req = try postReq.createReq()
                let body = try JSONDecoder().decode(JoinPartyRequest.self, from: req.httpBody!)
                #expect(req.httpMethod == "POST")
                #expect(req.url?.absoluteString == HTTP.PostRoutes.joinParty.fullURLString)
                #expect(body.userID == userID)
                #expect(body.partyCode == partyCode)
                #expect(body.username == userName)
            case .leaveParty(let userID):
                let req = try postReq.createReq()
                let body = try JSONDecoder().decode(LeavePartyRequest.self, from: req.httpBody!)
                #expect(req.httpMethod == "POST")
                #expect(req.url?.absoluteString == HTTP.PostRoutes.leaveParty.fullURLString)
                #expect(body.userID == userID)
            case .sendMessage(let userID, let username, let message, let partyID):
                let req = try postReq.createReq()
                let body = try JSONDecoder().decode(SendMessageRequest.self, from: req.httpBody!)
                #expect(req.httpMethod == "POST")
                #expect(req.url?.absoluteString == HTTP.PostRoutes.sendMessage.fullURLString)
                #expect(body.message == message)
                #expect(body.partyID == partyID)
                #expect(body.userID == userID)
                #expect(body.userName == username)
            case .updateRating(let partyID, let userName, let userID, let restaurantName, let rating, let imageuRL):
                let req = try postReq.createReq()
                let body = try JSONDecoder().decode(UpdateRatingRequest.self, from: req.httpBody!)
                #expect(req.httpMethod == "POST")
                #expect(req.url?.absoluteString == HTTP.PostRoutes.updateRating.fullURLString)
                #expect(body.imageURL == imageuRL)
                #expect(body.partyID == partyID)
                #expect(body.userID == userID)
                #expect(body.userName == userName)
                #expect(body.restaurantName == restaurantName)
                #expect(body.rating == rating)
            }
        } catch {
            Issue.record(error)
        }

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
