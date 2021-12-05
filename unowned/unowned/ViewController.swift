//
//  ViewController.swift
//  unowned
//
//  Created by Misha Causur on 19.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var supportCategoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        supportCategoriesCollectionView.register(UINib(nibName: "SupportCategoriesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SupportCategoriesCollectionViewCell")
    }
    
    @IBAction func closeApp(_ sender: Any) {
        exit(0)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var widthCell: CGFloat { return (view.frame.width - (9 * 3)) / 2 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categories.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = supportCategoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "SupportCategoriesCollectionViewCell", for: indexPath) as! SupportCategoriesCollectionViewCell
        cell.configureView(Categories.categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthCell, height: widthCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero, left: 4.5, bottom: 50, right: 4.5)
    }
    
}
