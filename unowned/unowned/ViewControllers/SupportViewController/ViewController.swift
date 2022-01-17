//
//  ViewController.swift
//  unowned
//
//  Created by Misha Causur on 19.11.2021.
// swiftlint:disable all

import UIKit

class ViewController: UIViewController {
    
    private var categories = SupportCategories()
    
    @IBOutlet private weak var supportCategoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        supportCategoriesCollectionView.register(UINib(nibName: "SupportCategoriesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SupportCategoriesCollectionViewCell")
    }
    
    @IBAction private func closeApp(_ sender: Any) {
        exit(0)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var widthCell: CGFloat { return (view.frame.width - (9 * 3)) / 2 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = supportCategoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "SupportCategoriesCollectionViewCell", for: indexPath) as! SupportCategoriesCollectionViewCell
        cell.configureView(categories.categories[indexPath.item])
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
        coordinator.eventOccurred(with: .toEvents, with: nil, categories.categories[indexPath.item].label)
    }
}

