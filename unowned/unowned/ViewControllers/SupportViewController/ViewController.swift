//
//  ViewController.swift
//  unowned
//
//  Created by Misha Causur on 19.11.2021.
// swiftlint:disable all

import UIKit

class ViewController: UIViewController {
    
    var categories: [String] = [] 
    
    private var viewModel: SupportViewOutput = SupportCategoriesViewModel()
    
    private let activity: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @IBOutlet private weak var supportCategoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndicator()
        viewModel.viewInput = self
        supportCategoriesCollectionView.register(UINib(nibName: "SupportCategoriesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SupportCategoriesCollectionViewCell")
        viewModel.firstData {
            self.viewModel.secondData()
        }
    }
    
    @IBAction private func closeApp(_ sender: Any) {
        exit(0)
    }
    
    func getCategories() {
        var array: [String] = []
        let items = CoreDataManager.shared.CDgetCategoriesForData()
        for i in items {
            if let j = i.name {
                let name = String("\(j)")
                array.append(name)
            }
            
        }
        categories = array.sorted { $0 < $1 }
    }
    private func addActivityIndicator() {
        view.addSubview(activity)
        activity.startAnimating()
        [activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         activity.centerYAnchor.constraint(equalTo: view.centerYAnchor)].forEach { $0.isActive = true }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var widthCell: CGFloat { return (view.frame.width - (9 * 3)) / 2 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = supportCategoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "SupportCategoriesCollectionViewCell", for: indexPath) as! SupportCategoriesCollectionViewCell
        cell.configureView(categories[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthCell, height: widthCell)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero, left: 4.5, bottom: 50, right: 4.5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navVC = navigationController else { return }
        let coordinator = AppCoordinator(navigationViewController: navVC)
        coordinator.eventOccurred(with: .toEvents, with: nil, categories[indexPath.item])
    }
}

extension ViewController: SupportViewInput {
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.activity.stopAnimating()
            self?.supportCategoriesCollectionView.reloadData()
        }
    }
}
