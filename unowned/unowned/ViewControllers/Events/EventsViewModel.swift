//
//  EventsViewModel.swift
//  unowned
//
//  Created by Misha Causur on 13.12.2021.
//

import Foundation

protocol EventsViewInput: AnyObject {
    func configureTableView(posts: [EventModel])
}

protocol EventsViewOutput: Coordinating {
    var viewInput: EventsViewInput? { get set }
    func getData()
}

class EventsViewModel: EventsViewOutput {
    var coordinator: Coordinator?
    weak var viewInput: EventsViewInput?
    var events: [EventModel]?
    func getData() {
        DataManager.shared.getData { events in
            DispatchQueue.main.async {
                self.events = events
                self.viewInput?.configureTableView(posts: events)
            }
            
        }
    }
}
