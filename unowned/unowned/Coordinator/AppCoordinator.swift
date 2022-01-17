//
//  AppCoordinator.swift
//  unowned
//
//  Created by Misha Causur on 13.12.2021.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var navigationViewController: UINavigationController?
    
    init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    func eventOccurred(with type: Events, with event: CDEvent?, _ category: String?) {
        switch type {
        case .toDetail:
            guard let event = event else {
                return
            }
            pushDetailViewController(event)
        case .toEvents:
            guard let category = category else {
                return
            }
            pushEventsViewController(category)
        }
    }
    private func pushEventsViewController(_ category: String) {
        let viewModel = EventsViewModel()
        viewModel.coordinator = self
        let viewController = EventsViewController(viewModel: viewModel)
        viewController.title = category
        viewModel.viewInput = viewController
        navigationViewController?.pushViewController(viewController, animated: true)
    }
    private func pushDetailViewController(_ event: CDEvent) {
        let viewModel = DetailViewModel(event: event)
        viewModel.coordinator = self
        let viewController = DetailViewController(viewModel: viewModel)
        navigationViewController?.pushViewController(viewController, animated: true)
    }
}
