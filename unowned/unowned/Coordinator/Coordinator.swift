//
//  Coordinator.swift
//  unowned
//
//  Created by Misha Causur on 13.12.2021.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationViewController: UINavigationController? { get set }
    func eventOccurred(with type: Events, with event: EventModel?, _ category: String?)
}
