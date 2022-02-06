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
// MARK: - метод получения категорий
    func getCategories(completion: @escaping ([CategoryAPI]) -> Void) {
// Проверяем валидность ссылки через ранний выход
        guard let url = URL(string: URLLinks.shared.categoriesURL) else { return }
// Запускаем URL сессию
        URLSession.shared.dataTaskPublisher(for: url)
// устанавливаем работу на бекграунд потоке
            .subscribe(on: DispatchQueue.global(qos: .background))
// возвращаем на главном потоке (так как будет взаимодействие с UI)
            .receive(on: DispatchQueue.main)
// Проверяем ответ от сервера на наличие ошибок
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
// В случае, если нет ответа от сервера, грузим данные из CoreData
                          let cats = DataManager.shared.castCDCategoriesToStrings()
                          completion(cats)
                          throw URLError(.badServerResponse)
                      }
                return data
            }
// Десериализуем полученные данные через Декодер
            .decode(type: [CategoryAPI].self, decoder: JSONDecoder())
            .sink { (completion) in
                print("COMPLETION: \(completion)")
            } receiveValue: { (returnedCategories) in
// возвращаем десериализованные данные в массиве
                completion(returnedCategories)
            }
// добавляем возможность отмены действия
            .store(in: &cancellables)
    }
// MARK: -  метод получения событий
    func getData(completion: @escaping ([EventModel]) -> Void) {
// делаем запрос к серверу и получаем данные/ошибку
        guard let url = URL(string: URLLinks.shared.eventsURL) else { return }
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
// если ошибочка, то пишем в консоль какая именно
            guard error == nil else {
                print("an error occured \(String(describing: error?.localizedDescription))")
                return
            }
            guard let data1 = data else {
                return
            }
            do {
// десeриализуем данные с сервера в json в структуру данных
                let events = try JSONDecoder().decode([EventModel].self, from: data1)
                completion(events)} catch let error {
// если ошибка, то грузим данные из CoreData
                let CDPosts = CoreDataManager.shared.CDgetData()
                let posts = DataManager.shared.mapData(CDPosts)
                completion(posts)
                print("catch error \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
