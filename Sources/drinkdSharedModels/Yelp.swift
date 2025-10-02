//
//  File.swift
//  drinkdSharedModels
//
//  Created by Enzo Herrera on 10/2/25.
//

import Foundation

//Main Query
public struct YelpApiBusinessSearch: Codable {
    public let businesses: [YelpApiBusinessSearchProperties]?
}

//Business Search
public struct YelpApiBusinessSearchProperties: Codable, Hashable {
    public let id: String?
    public let alias: String?
    public let name: String?
    public let image_url: String?
    public let is_closed: Bool?
    public let url: String?
    public let review_count: Int?
    public let categories: [YelpApiBusinessDetails_Categories]?
    public let rating: Double?
    public let coordinates: YelpApiBusinessDetails_Coordinates?
    public let transactions: [String]?
    public let price: String?
    public let location: YelpApiBusinessDetails_Location?
    public let phone: String?
    public let display_phone: String?
    public let distance: Double?
    //Custom Properties, not from API
//    var imageData: Data?
    public var pickUpAvailable: Bool?
    public var deliveryAvailable: Bool?
    public var reservationAvailable: Bool?
}


//Business Details
public struct YelpApiBusinessDetails: Codable {
    public let id: String?
    public let alias: String?
    public let name: String?
    public let image_url: String?
    public let is_claimed: Bool?
    public let is_closed: Bool?
    public let url: String?
    public let phone: String?
    public let display_phone: String?
    public let review_count: Int?
    public let categories: [YelpApiBusinessDetails_Categories]?
    public let rating: Double?
    public let location: YelpApiBusinessDetails_Location?
    public let coordinates: YelpApiBusinessDetails_Coordinates?
    public let photos: [String]?
    public let price: String?
    public let hours: [YelpApiBusinessDetails_Hours]?
    public let transactions: [String]?
    public let special_hours: [YelpApiBusinessDetails_SpecialHours]?
}

public struct YelpApiBusinessDetails_Categories: Codable, Hashable {
    public let alias: String?
    public let title: String?
}

public struct YelpApiBusinessDetails_Location: Codable, Hashable {
    public let address1: String?
    public let address2: String?
    public let address3: String?
    public let city: String?
    public let zip_code: String?
    public let country: String?
    public let state: String?
    public let display_address: [String]?
    public let cross_streets: String?
}

public struct YelpApiBusinessDetails_Coordinates: Codable, Hashable {
    public let latitude: Double?
    public let longitude: Double?
}

public struct YelpApiBusinessDetails_Hours: Codable {
    public let open: [YelpApiBusinessDetails_Hours_Open]?
    public let hours_type: String?
    public let is_open_now: Bool?
}

public struct YelpApiBusinessDetails_Hours_Open: Codable {
    public let is_overnight: Bool?
    public let start: String?
    public let end: String?
    public let day: Int?
}

public struct YelpApiBusinessDetails_SpecialHours: Codable {
    public let date: String?
    public let is_closed: Bool?
    public let start: String?
    public let end: String?
    public let is_overnight: Bool?
}


