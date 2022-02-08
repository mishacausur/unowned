//
//  AlamofireManager.swift
//  unowned
//
//  Created by Misha Causur on 30.01.2022.
//

import Foundation
import Alamofire

class AlamofireManager {
    static let shared = AlamofireManager()
// MARK: - Метод получения категорий
    func getCategories(completion: @escaping ([CategoryAPI]) -> Void) {
        AF.request(URLLinks.shared.categoriesURL).response { response in
            guard let data = response.data else { return }
            do {
                let categories = try JSONDecoder().decode([CategoryAPI].self, from: data)
                completion(categories)} catch let error {
                let cats = DataManager.shared.castCDCategoriesToStrings()
                completion(cats)
                print(error.localizedDescription)
            }
        }
    }
// MARK: - Метод получения событий
    func getData(completion: @escaping ([EventModel]) -> Void) {
        AF.request(URLLinks.shared.eventsURL).response { response in
            guard let data = response.data else { return }
            do {
                let events = try JSONDecoder().decode([EventModel].self, from: data)
                completion(events)} catch let erroe {
                let CDPosts = CoreDataManager.shared.CDgetData()
                let posts = DataManager.shared.mapData(CDPosts)
                completion(posts)
                print(erroe.localizedDescription)
            }
        }
    }
}
