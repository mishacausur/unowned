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
    func getData(completion: @escaping ([EventModel]) -> Void) {
        AF.request("https://unowned-1057d-default-rtdb.firebaseio.com/events.json").response { response in
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
