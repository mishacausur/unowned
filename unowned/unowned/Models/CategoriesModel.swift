//
//  CategoriesModel.swift
//  unowned
//
//  Created by Misha Causur on 15.12.2021.
//

import Foundation

struct CategoryAPI: Codable {
    let name: String
}

extension CategoryAPI: Comparable {
    static func < (lhs: CategoryAPI, rhs: CategoryAPI) -> Bool {
        lhs.name < rhs.name
    }
    
    
}
