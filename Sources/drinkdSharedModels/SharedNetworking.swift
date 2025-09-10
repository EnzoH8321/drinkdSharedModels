//
//  Networking.swift
//  drinkdSharedModels
//
//  Created by Enzo Herrera on 5/8/25.
//
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public final class SharedNetworking {
    @MainActor public static let shared = SharedNetworking()
    private init() { }
}

protocol URLRequestProtocol {
    func createReq() throws -> URLRequest
}

protocol RoutesProtocol {
    var fullURLString: String { get }
}

public enum HTTP {

    private static var baseURLString: String {
#if DEVELOPMENT
        return "http://localhost:8080/"
#else
        return "https://drinkdvaporserver.fly.dev/"
#endif
    }

    public enum PostRoutes: String, CaseIterable, RoutesProtocol {
        case createParty
        case joinParty
        case leaveParty
        case sendMessage
        case updateRating

        var fullURLString: String {
            return baseURLString + self.rawValue
        }
    }

    public enum GetRoutes: String, CaseIterable, RoutesProtocol {
        case topRestaurants
        case rejoinParty
        case getMessages
        case ratedRestaurants

        var fullURLString: String {
            return baseURLString + self.rawValue
        }
    }

    public enum GetReq: URLRequestProtocol, Sendable {

        case topRestaurants(partyID: UUID)
        case rejoinParty(userID: String)
        case getMessages(partyID: UUID)
        case ratedRestaurants(userID: UUID, partyID: UUID)

        /// Creates GET request with appropriate query parameters
        /// - Returns: Configured URLRequest
        /// - Throws: ClientNetworkErrors.invalidURLError if URL is invalid
        public func createReq() throws -> URLRequest {
            /// Extract URL and query items based on case
            let (url, queryItems) = urlComponents

            /// Build URL with query parameters
            guard var components = URLComponents(string: url) else {
                throw SharedErrors.general(error: .generalError("Unable to construct valid URLComponents"))

            }

            components.queryItems = queryItems

            guard let finalURL = components.url else {
                throw SharedErrors.general(error: .generalError("Unable to retrieve a valid URL"))
            }

            /// Create GET request
            var request = URLRequest(url: finalURL)
            request.httpMethod = "GET"
            return request
        }

        /// Extracts URL and query items for each case
        public var urlComponents: (url: String, queryItems: [URLQueryItem]) {
            switch self {
            case .topRestaurants(let partyID):
                return (HTTP.GetRoutes.topRestaurants.fullURLString, [URLQueryItem(name: "partyID", value: partyID.uuidString)])

            case .rejoinParty(let userID):
                return (HTTP.GetRoutes.rejoinParty.fullURLString, [URLQueryItem(name: "userID", value: userID)])

            case .getMessages(let partyID):
                return (HTTP.GetRoutes.getMessages.fullURLString, [URLQueryItem(name: "partyID", value: partyID.uuidString)])

            case .ratedRestaurants(let userID, let partyID):
                return (HTTP.GetRoutes.ratedRestaurants.fullURLString, [
                    URLQueryItem(name: "userID", value: userID.uuidString),
                    URLQueryItem(name: "partyID", value: partyID.uuidString)
                ])
            }
        }
    }

    public enum PostReq: URLRequestProtocol, Sendable {

        case createParty(userID: UUID, userName: String, restaurantsUrl: String, partyName: String)
        case joinParty(userID: UUID, partyCode: Int, userName: String)
        case leaveParty(userID: UUID)
        case sendMessage(userID: UUID, username: String, message: String, partyID: UUID)
        case updateRating(partyID: UUID,  userName: String ,  userID: UUID,  restaurantName: String, rating: Int,  imageuRL: String)

        public func createReq() throws -> URLRequest {

            let (endpoint, requestBody): (PostRoutes, Encodable) = switch self {
            case .createParty(let userID, let userName, let restaurantsUrl, let partyName):
                (.createParty, CreatePartyRequest(username: userName, userID: userID, restaurants_url: restaurantsUrl, partyName: partyName))

            case .joinParty(let userID, let partyCode, let userName):
                (.joinParty, JoinPartyRequest(userID: userID, username: userName, partyCode: partyCode))

            case .leaveParty(let userID):
                (.leaveParty, LeavePartyRequest(userID: userID))

            case .sendMessage(let userID, let username, let message, let partyID):
                (.sendMessage, SendMessageRequest(userID: userID, username: username, partyID: partyID, message: message))

            case .updateRating(let partyID, let userName, let userID, let restaurantName, let rating, let imageURL):
                (.updateRating, UpdateRatingRequest(partyID: partyID, userID: userID, userName: userName, restaurantName: restaurantName, rating: rating, imageURL: imageURL))
            }

            do {
                /// Build request with JSON body
                var request = try buildPostReq(url: endpoint.fullURLString)
                request.httpBody = try JSONEncoder().encode(requestBody)
                return request
            } catch {
                let errorString = errorMessage(error)
                Log.logger.error(" \(errorString)")
                throw error
            }

        }

        private func errorMessage(_ error: Error) -> String {
            switch self {
            case .createParty(let userID, let userName, let restaurantsUrl, let partyName):
                return "Error encoding JSON when creating a party - \(error)"
            case .joinParty(let userID, let partyCode, let userName):
                return "Error encoding JSON when joining a party - \(error)"
            case .leaveParty(let userID):
                return "Error encoding JSON when leaving a party - \(error)"
            case .sendMessage(let userID, let username, let message, let partyID):
                return "Error encoding JSON when sending a message - \(error)"
            case .updateRating(let partyID, let userName, let userID, let restaurantName, let rating, let imageuRL):
                return "Error encoding JSON when updating a rating - \(error)"
            }

        }

        // Post Req
        private func buildPostReq(url: String) throws -> URLRequest {
            guard let url = URL(string: url) else { throw SharedErrors.general(error: .generalError("Unable to create a valid URL"))}
            var urlRequest = URLRequest(url: url)

            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

            return urlRequest
        }

    }
}
