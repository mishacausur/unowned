//
//  ViewController.swift
//  unowned
//
//  Created by Misha Causur on 19.11.2021.
// swiftlint:disable all

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet var categoiesLabel: UILabel!
    var categories: [String] = []
    
    private var viewModel: SupportViewOutput = SupportCategoriesViewModel()
    
    @IBOutlet private weak var supportCategoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoiesLabel.alpha = 0
        viewModel.viewInput = self
        supportCategoriesCollectionView.register(UINib(nibName: "SupportCategoriesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SupportCategoriesCollectionViewCell")
        viewModel.firstData()
        viewModel.getCats()
    }
    
    @IBAction private func closeApp(_ sender: Any) {
        exit(0)
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
            defer { withExtendedLifetime(self) {} }
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                self?.categoiesLabel.alpha = 1
                self?.supportCategoriesCollectionView.reloadData()
            }
           
        }
    }
}
