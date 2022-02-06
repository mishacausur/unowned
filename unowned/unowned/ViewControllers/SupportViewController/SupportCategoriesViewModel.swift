//
//  SupportCategoriesViewModel.swift
//  unowned
//
//  Created by Misha Causur on 21.01.2022.
//

import Foundation
import SwiftUI
import Combine

protocol SupportViewInput: AnyObject {
    var categories: [String] {get set}
    func reload()
}

protocol SupportViewOutput {
    var viewInput: SupportViewInput? { get set }
    func firstData()
    func saveData()
    func getCats()
}

class SupportCategoriesViewModel: SupportViewOutput {
    weak var viewInput: SupportViewInput?
// MARK: - Подготовка данный для представления на UI (считывание наименование категории и передача значения в виде строки на контроллер)
    func castCategories(_ cats: [CategoryAPI]) -> [String] {
        var array: [String] = []
        for item in cats {
            let name = item.name
            print(name)
            array.append(name)
        }
        return array.sorted { $0 < $1 }
    }
// MARK: - Получение категорий через URLSession
    func getCats() {
        // получаем данные через URLSession
        FirebaseManager.shared.getCategories { [weak self] categories in
            let cats = self?.castCategories(categories)
            self?.viewInput?.categories = cats!
            self?.viewInput?.reload()
        }
        // получаем данные через Alamofire
        AlamofireManager.shared.getCategories { [weak self] categories in
            let cats = self?.castCategories(categories)
            self?.viewInput?.categories = cats!
            self?.viewInput?.reload()
        }
    }
// MARK: - Считывание данных из локального json и передача данных на сохранение в CoreData
    func firstData() {
        DataManager.shared.getCategoriesData { category in
            self.saveData()
            let queue = DispatchQueue.init(label: "datas", qos: .background, attributes: .concurrent)
            for item in category {
                queue.async { [weak self] in
                    CoreDataManager.shared.saveCategories(item) {_ in
                        self?.viewInput?.reload()
                    }
                }
            }
        }
    }
// MARK: - Загрузка событий из json файла и сохранение их в CoreData
    func saveData() {
        DataManager.shared.getData { [weak self] events in
            DispatchQueue.main.async {
                self?.saveDataToDB(events)
            }
        }
    }
    func saveDataToDB(_ events: [EventModel]) {
        for item in events {
            CoreDataManager.shared.save(item) {_ in
            }
        }
    }
}
