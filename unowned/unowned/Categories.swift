//
//  Categories.swift
//  unowned
//
//  Created by Misha Causur on 05.12.2021.
//

import Foundation
import UIKit

struct Categories {
    let icon: UIImage
    let label: String
}

struct SupportCategories {
    let child = Categories(icon: UIImage(named: "childIcon")!, label: "Дети")
    let adult = Categories(icon: UIImage(named: "adultIcon")!, label: "Взрослые")
    let aged = Categories(icon: UIImage(named: "agedIcon")!, label: "Пожилые")
    let animals = Categories(icon: UIImage(named: "animalsIcon")!, label: "Животные")
    let events = Categories(icon: UIImage(named: "eventsIcon")!, label: "Мероприятия")
    lazy var categories: [Categories] = [child, adult, aged, animals, events]
}
