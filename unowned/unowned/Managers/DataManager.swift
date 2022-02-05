//
//  DataManager.swift
//  unowned
//
//  Created by Misha Causur on 17.12.2021.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    func getData(completion: @escaping ([EventModel]) -> Void ) {
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: path)
                var result: [EventModel]?
                let data = contents.data(using: .utf8)
                do {
                    guard let data = data else { return }
                    result = try JSONDecoder().decode([EventModel].self, from: data)
                    guard let result = result else { return }
                    completion(result)
                } catch let error {
                    print("Cant decode \(error.localizedDescription)")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("data file doesn't found :(")
        }
    }
    func getCategoriesData(completion: @escaping ([CategoryAPI]) -> Void ) {
        if let path = Bundle.main.path(forResource: "Categories", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: path)
                var result: [CategoryAPI]?
                let data = contents.data(using: .utf8)
                do {
                    guard let data = data else { return }
                    result = try JSONDecoder().decode([CategoryAPI].self, from: data)
                    guard let result = result else { return }
                    completion(result)
                } catch let error {
                    print("Cant decode \(error.localizedDescription)")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("data file doesn't found :(")
        }
    }
    func mapData(_ events: [CDEvent]) -> [EventModel] {
        var models: [EventModel] = []
        for event in events {
            let model = castCDDataToModel(event)
                models.append(model)
        }
        return models.compactMap { $0 }
    }
    func castCDDataToModel(_ event: CDEvent) -> EventModel {
        if let address = event.address,
           let cat = event.category,
           let id = event.identify,
           let name = event.name,
           let description = event.disrcrptn,
           let startDate = Int(event.startDate!),
           let endDate = Int(event.endDate!) {
            let phones = getPhoneNumbers(event)
            let category = CategoryAPI(name: cat)
            let model = EventModel(id: id, category: category, name: name, welcomeDescription: description, startDate: startDate, endDate: endDate, address: address, phoneNumbers: phones)
            return model
        } else {
            fatalError()
        }
    }
    func getPhoneNumbers(_ event: CDEvent) -> [PhoneNumber] {
        var items: [PhoneNumber] = []
        guard let id = event.identify else { return [] }
        let phones = CoreDataManager.shared.CDgetPhoneNumbers(for: id)
        for phone in phones {
            let number = PhoneNumber(number: phone.number!)
            items.append(number)
        }
       return items
    }
    
    func castCDCategoriesToStrings() -> [CategoryAPI] {
        var array: [CategoryAPI] = []
        let items = CoreDataManager.shared.CDgetCategoriesForData()
        for item in items {
            if let jtem = item.name {
                let name = String("\(jtem)")
                let category = CategoryAPI(name: name)
                array.append(category)
            }
        }
        return array.sorted { $0 < $1 }
    }
}
