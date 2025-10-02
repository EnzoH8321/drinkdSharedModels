//
//  File.swift
//  drinkdSharedModels
//
//  Created by Enzo Herrera on 10/2/25.
//

import Foundation

//Main Query
public struct YelpApiBusinessSearch: Codable {
    let businesses: [YelpApiBusinessSearchProperties]?
}

//Business Search
public struct YelpApiBusinessSearchProperties: Codable, Hashable {
    let id: String?
    let alias: String?
    let name: String?
    let image_url: String?
    let is_closed: Bool?
    let url: String?
    let review_count: Int?
    let categories: [YelpApiBusinessDetails_Categories]?
    let rating: Double?
    let coordinates: YelpApiBusinessDetails_Coordinates?
    let transactions: [String]?
    let price: String?
    let location: YelpApiBusinessDetails_Location?
    let phone: String?
    let display_phone: String?
    let distance: Double?
    //Custom Properties, not from API
//    var imageData: Data?
    var pickUpAvailable: Bool?
    var deliveryAvailable: Bool?
    var reservationAvailable: Bool?
}


//Business Details
public struct YelpApiBusinessDetails: Codable {
    let id: String?
    let alias: String?
    let name: String?
    let image_url: String?
    let is_claimed: Bool?
    let is_closed: Bool?
    let url: String?
    let phone: String?
    let display_phone: String?
    let review_count: Int?
    let categories: [YelpApiBusinessDetails_Categories]?
    let rating: Double?
    let location: YelpApiBusinessDetails_Location?
    let coordinates: YelpApiBusinessDetails_Coordinates?
    let photos: [String]?
    let price: String?
    let hours: [YelpApiBusinessDetails_Hours]?
    let transactions: [String]?
    let special_hours: [YelpApiBusinessDetails_SpecialHours]?
}

public struct YelpApiBusinessDetails_Categories: Codable, Hashable {
    let alias: String?
    let title: String?
}

public struct YelpApiBusinessDetails_Location: Codable, Hashable {
    let address1: String?
    let address2: String?
    let address3: String?
    let city: String?
    let zip_code: String?
    let country: String?
    let state: String?
    let display_address: [String]?
    let cross_streets: String?
}

public struct YelpApiBusinessDetails_Coordinates: Codable, Hashable {
    let latitude: Double?
    let longitude: Double?
}

public struct YelpApiBusinessDetails_Hours: Codable {
    let open: [YelpApiBusinessDetails_Hours_Open]?
    let hours_type: String?
    let is_open_now: Bool?
}

public struct YelpApiBusinessDetails_Hours_Open: Codable {
    let is_overnight: Bool?
    let start: String?
    let end: String?
    let day: Int?
}

public struct YelpApiBusinessDetails_SpecialHours: Codable {
    let date: String?
    let is_closed: Bool?
    let start: String?
    let end: String?
    let is_overnight: Bool?
}


