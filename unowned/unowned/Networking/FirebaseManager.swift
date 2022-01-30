//
//  FirebaseManager.swift
//  unowned
//  Created by Misha Causur on 30.01.2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    var ref: DatabaseReference = Database.database().reference()

    func getData(completion: @escaping ([EventModel]) -> Void) {
// MARK: - делаем запрос к серверу и получаем данные/ошибку
        let url = URL(string: "https://unowned-1057d-default-rtdb.firebaseio.com/events.json")!
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
// MARK: - если ошибочка, то пишем в консоль какая именно
            guard error == nil else {
                print("an error occured \(String(describing: error?.localizedDescription))")
                return
            }
            guard let data1 = data else {
                return
            }
            do {
// MARK: - десeриализуем данные с сервера в json в структуру данных
                let events = try JSONDecoder().decode([EventModel].self, from: data1)
                completion(events)} catch let error {
// MARK: - если ошибка, то грузим данные из CoreData
                let CDPosts = CoreDataManager.shared.CDgetData()
                let posts = DataManager.shared.mapData(CDPosts)
                completion(posts)
                print("catch error \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
