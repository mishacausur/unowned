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
            do { let contents = try String(contentsOfFile: path)
                var result: [EventModel]?
                let data = contents.data(using: .utf8)
                print(data)
                do {
                    guard let data = data else { return }
                    result = try JSONDecoder().decode([EventModel].self, from: data)
                    completion(result!)
                    print(result)
                }
                catch let error{
                    print("Cant decode \(error.localizedDescription)")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("data file doesn't found :(")
        }
    }
}
