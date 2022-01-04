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
    private let backgroundView = UIView()
    private let activity: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addActivityIndicator()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func stopActivity() {
    }
    func configureViews(_ events: [EventModel]) {
        let tableView = EventsTableView(frame: .zero, events: events)
        self.addSubviews(segmentController, backgroundView)
        backgroundView.addSubview(tableView)
        backgroundView.alpha = 0
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.completion = { [weak self] index in
            self?.completion?(events[index])
        }
        let contraints = [
            segmentController.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentController.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentController.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: segmentController.bottomAnchor, constant: 9.5),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            activity.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: self.centerYAnchor)]
        NSLayoutConstraint.activate(contraints)
        animatedMoves()
        activity.stopAnimating()
    }
    private func animatedMoves() {
        let animator = UIViewPropertyAnimator(duration: 0.4, curve: .easeInOut) {
            self.backgroundView.alpha = 1
        }
        animator.startAnimation()
    }
    private func addActivityIndicator() {
        self.addSubview(activity)
        activity.startAnimating()
        [activity.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         activity.centerYAnchor.constraint(equalTo: self.centerYAnchor)].forEach { $0.isActive = true }
    }
}
