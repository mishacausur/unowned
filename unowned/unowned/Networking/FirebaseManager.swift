//
//  FirebaseManager.swift
//  unowned
//  Created by Misha Causur on 30.01.2022.
//

import Foundation
import UIKit
import Combine
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore

class FirebaseManager {
    var cancellables = Set<AnyCancellable>()
    static let shared = FirebaseManager()
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
    func getCategories(completion: @escaping ([CategoryAPI]) -> Void) {

// MARK: - Проверяем валидность ссылки через ранний выход
        guard let url = URL(string: "https://unowned-1057d-default-rtdb.firebaseio.com/Categories.json") else { return }
// MARK: - Запускаем URL сессию
        URLSession.shared.dataTaskPublisher(for: url)
// MARK: - устанавливаем работу на бекграунд потоке
            .subscribe(on: DispatchQueue.global(qos: .background))
// MARK: - возвращаем на главном потоке (так как будет взаимодействие с UI)
            .receive(on: DispatchQueue.main)
// MARK: - Проверяем ответ от сервера на наличие ошибок
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
// MARK: - В случае, если нет ответа от сервера, грузим данные из CoreData
                          let cats = DataManager.shared.castCDCategoriesToStrings()
                          completion(cats)
                          throw URLError(.badServerResponse)
                      }
                return data
            }
// MARK: - Десериализуем полученные данные через Декодер
            .decode(type: [CategoryAPI].self, decoder: JSONDecoder())
            .sink { (completion) in
                print("COMPLETION: \(completion)")
            } receiveValue: { (returnedCategories) in
// MARK: - возвращаем десериализованные данные в массиве
                completion(returnedCategories)
            }
// MARK: - добавляем возможность отмены действия 
            .store(in: &cancellables)
    }
}
