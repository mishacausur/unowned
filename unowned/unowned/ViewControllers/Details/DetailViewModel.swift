//
//  DetailViewModel.swift
//  unowned
//
//  Created by Misha Causur on 19.12.2021.
//

import Foundation

protocol DetailViewInput: AnyObject {
    
}

protocol DetailViewOutput: Coordinating {
    var viewInput: DetailViewInput? { get set }
    var event: CDEvent { get }
}

class DetailViewModel: DetailViewOutput {
    var coordinator: Coordinator?
    weak var  viewInput: DetailViewInput?
    var event: CDEvent
    init(event: CDEvent) {
        self.event = event
    }
}
