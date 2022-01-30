//
//  FirebaseManager.swift
//  unowned
// swiftlint:disable all
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
        
        let url = URL(string: "https://unowned-1057d-default-rtdb.firebaseio.com/events.json")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("an error occured \(error?.localizedDescription)")
                return
            }
            guard let data1 = data else {
                return
            }
            do {
                let events = try JSONDecoder().decode([EventModel].self, from: data1)
                completion(events)
            }
            catch let error {
                print("catch error \(error.localizedDescription)")
            }
        }

        session.resume()
    }
}

struct Model: Codable {
    let address: String
}
