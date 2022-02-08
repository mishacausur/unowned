//
//  EventsViewController.swift
//  unowned
//
//  Created by Misha Causur on 13.12.2021.
//

import UIKit

class EventsViewController: UIViewController, ViewControllerable {

    typealias RootView = EventsView
    var viewModel: EventsViewOutput
    init(viewModel: EventsViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        viewModel.viewInput = self
        self.navigationItem.hidesBackButton = true
        view().completion = { [weak self] event in
            defer { withExtendedLifetime(self) {} }
            self?.viewModel.coordinator?.eventOccurred(with: .toDetail, with: event, nil)
        }
    }
    override func loadView() {
        let view = EventsView()
        self.view = view
    }
}

extension EventsViewController: EventsViewInput {
    func configureTableView(posts: [EventModel]) {
        DispatchQueue.main.async { [weak self] in
            defer { withExtendedLifetime(self) {} }
            self?.view().configureViews(posts)
        }
    }
}
