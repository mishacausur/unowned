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
    let queue = DispatchQueue(label: "background", qos: .background, attributes: .concurrent)
    func getData() {
        DispatchQueue.main.async {
            let models = FirebaseManager.shared.getData { [weak self] posts in
                self?.viewInput?.configureTableView(posts: posts)
            }
//            let CDPosts = self.readDataFromDB()
//            let posts = DataManager.shared.mapData(CDPosts)
//            self.viewInput?.configureTableView(posts: posts)
        }
    }
    func readDataFromDB() -> [CDEvent] {
        let events = CoreDataManager.shared.CDgetData()
        return events
    }
}
