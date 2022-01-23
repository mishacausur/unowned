//
//  SupportCategoriesCollectionViewCell.swift
//  unowned
//
//  Created by Misha Causur on 05.12.2021.
//

import UIKit

class SupportCategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor(named: "lightOliveGreen")
        contentView.backgroundColor = UIColor(named: "lightGreyTwo")
    }

    func configureView(_ category: String) {
        label.text = category
        switch category {
        case "Дети":
            iconImage.image = UIImage(named: "childIcon")!
        case "Взрослые":
            iconImage.image = UIImage(named: "adultIcon")!
        case "Пожилые":
            iconImage.image = UIImage(named: "agedIcon")!
        case "Животные":
            iconImage.image = UIImage(named: "animalsIcon")!
        case "Мероприятия":
            iconImage.image = UIImage(named: "eventsIcon")!
        default:
            break
        }
    }
}

