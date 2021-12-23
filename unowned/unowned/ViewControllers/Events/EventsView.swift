//
//  EventsView.swift
//  unowned
//
//  Created by Misha Causur on 13.12.2021.
//

import Foundation
import UIKit

class EventsView: UIView {
    
    var completion: ((EventModel) -> Void)?
    
    let segmentController: UISegmentedControl = {
        let items = ["Текущие", "Завершенные"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.clipsToBounds = true
        control.layer.cornerRadius = 1
        control.layer.borderWidth = 1
        control.layer.borderColor = Color.color(.leaf).cgColor
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentTintColor = Color.color(.leaf)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.color(.leaf)], for: UIControl.State.normal)
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureViews(_ events: [EventModel]) {
        let tableView = EventsTableView(frame: .zero, events: events)
        self.addSubviews(segmentController, tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.completion = { [weak self] index in
            self?.completion?(events[index])
        }
        let contraints = [
            segmentController.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentController.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentController.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: segmentController.bottomAnchor, constant: 9.5),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        NSLayoutConstraint.activate(contraints)
    }
}
