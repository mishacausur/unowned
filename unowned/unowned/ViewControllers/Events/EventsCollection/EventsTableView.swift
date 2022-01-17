//
//  EventsTableView.swift
//  unowned
//  swiftlint:disable all
//  Created by Misha Causur on 14.12.2021.
//

import Foundation
import UIKit

class EventsTableView: UIView {
    
    var completion: ((Int) -> Void)?
    
    var events: [EventModel]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    init(frame: CGRect, events: [EventModel]) {
        self.events = events
        super.init(frame: frame)
        self.backgroundColor = Color.color(.lightGrey)
        print(events.count)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubviews(tableView)
        tableView.backgroundColor = Color.color(.lightGrey)
        [tableView.topAnchor.constraint(equalTo: self.topAnchor),
         tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)].forEach { $0.isActive = true }
    }
}

extension EventsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventsTableViewCell
        cell.configure(events[indexPath.row])
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion?(indexPath.row)
    }
}
