//
//  EventModel.swift
//  unowned
//
//  Created by Misha Causur on 15.12.2021.
//

import Foundation

struct EventModel: Codable {
    let id: String
    let category: CategoryAPI
    let name, welcomeDescription: String
    let startDate, endDate: Int
    let address: String
    let phoneNumbers: [PhoneNumber]

    enum CodingKeys: String, CodingKey {
        case id, category, name
        case welcomeDescription = "description"
        case startDate = "start_date"
        case endDate = "end_date"
        case address, phoneNumbers
    }
}
