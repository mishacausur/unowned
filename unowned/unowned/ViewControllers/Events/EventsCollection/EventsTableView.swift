//
//  EventsTableView.swift
//  unowned
//
//  Created by Misha Causur on 14.12.2021.
//

import Foundation
import UIKit

class EventsTableView: UIView {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubviews(tableView)
        
        [tableView.topAnchor.constraint(equalTo: self.topAnchor),
         tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)].forEach { $0.isActive = true }
    }
}

extension EventsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
}
