//
//  EventsViewModel.swift
//  unowned
//
//  Created by Misha Causur on 13.12.2021.
//

import Foundation

protocol EventsViewInput: AnyObject {
    func configureTableView(posts: [CDEvent])
}

protocol EventsViewOutput: Coordinating {
    var viewInput: EventsViewInput? { get set }
    func getData()
}

class EventsViewModel: EventsViewOutput {
    var coordinator: Coordinator?
    weak var viewInput: EventsViewInput?
    var events: [EventModel]?
    let queue = DispatchQueue(label: "background", qos: .background, attributes: .concurrent)
    func getData() {
        queue.sync {
            self.viewInput?.configureTableView(posts: self.readDataFromDB())
        }
    }
    
    func readDataFromDB() -> [CDEvent] {
        let events = CoreDataManager.shared.CDgetData()
        return events
    }
}
