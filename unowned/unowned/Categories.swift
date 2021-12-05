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
    
    static let categories: [Categories] = [Categories(icon: UIImage(named: "childIcon")!, label: "Дети"), Categories(icon: UIImage(named: "adultIcon")!, label: "Взрослые"), Categories(icon: UIImage(named: "agedIcon")!, label: "Пожилые"), Categories(icon: UIImage(named: "animalsIcon")!, label: "Животные"), Categories(icon: UIImage(named: "eventsIcon")!, label: "Мероприятия")]
}
