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
// MARK: - получение данных с помощью Alamofire
    func getData() {
        queue.async {
            AlamofireManager.shared.getData { [weak self] posts in
                DispatchQueue.main.async {
                    self?.viewInput?.configureTableView(posts: posts)
                }
            }
        }
    }
// MARK: - получение данные с помощью URLSession
//    func getData() {
//        queue.async {
//            let models = FirebaseManager.shared.getData { [weak self] posts in
//                DispatchQueue.main.async {
//                    self?.viewInput?.configureTableView(posts: posts)
//                }
//            }
//        }
//    }
// MARK: - получение данных из CoreData
//    func getData() {
//        DispatchQueue.main.async {
//            let CDPosts = self.readDataFromDB()
//            let posts = DataManager.shared.mapData(CDPosts)
//            self.viewInput?.configureTableView(posts: posts)
//        }
//    }
    func readDataFromDB() -> [CDEvent] {
        let events = CoreDataManager.shared.CDgetData()
        return events
    }
}
