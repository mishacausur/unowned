//
//  SupportCategoriesViewModel.swift
//  unowned
//
//  Created by Misha Causur on 21.01.2022.
//

import Foundation

protocol SupportViewInput: AnyObject {
    var categories: [String] {get set}
    func getCategories()
    func reload()
}

protocol SupportViewOutput {
    var viewInput: SupportViewInput? { get set }
    func firstData(completion: @escaping ()->())
    func secondData()
    func saveData()
}

class SupportCategoriesViewModel: SupportViewOutput {
   
    func firstData(completion: @escaping ()->()) {
        DataManager.shared.getCategoriesData { category in
            self.saveData()
            let queue = DispatchQueue.init(label: "datas", qos: .background, attributes: .concurrent)
            for item in category {
                queue.async { [weak self] in
                    CoreDataManager.shared.saveCategories(item, completion: {_ in
                        self?.secondData()
                    })
                }
            }
        }
    }
    func secondData() {
        viewInput?.getCategories()
        viewInput?.reload()
    }
    
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
    
    weak var viewInput: SupportViewInput?
}
