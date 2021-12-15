//
//  Coordinator.swift
//  unowned
//
//  Created by Misha Causur on 13.12.2021.
//

import Foundation

protocol Coordinator {
    var navigationViewController: UINavigationController? { get set }
    func eventOccurred(with type: Event, with string: String?)
}

protocol Coordinating {
    var coordinator: Coordinator { get set }
}

class AppCoordinator: Coordinator {
    
}
