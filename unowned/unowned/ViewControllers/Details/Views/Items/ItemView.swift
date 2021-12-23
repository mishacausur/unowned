//
//  ItemView.swift
//  unowned
//
//  Created by Misha Causur on 23.12.2021.
//

import UIKit

struct Item {
    let image: String
    let label: String
    
    static let items: [Item] = [Item(image: "shirt", label: "Помочь вещами"),
                                Item(image: "hands", label: "Стать волонтером"),
                                Item(image: "tools", label: "Проф. помощь"),
                                Item(image: "coins", label: "Помочь деньгами")]
}

class ItemView: UIView {
    
    private let icon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Color.color(.warmGrey)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(_ image: UIImage, text: String) {
        icon.image = image
        label.text = text
    }
    private func  configureViews() {
        self.addSubviews(icon, label)
        let constraints = [
            icon.heightAnchor.constraint(equalToConstant: 19),
            icon.widthAnchor.constraint(equalToConstant: 22),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            icon.bottomAnchor.constraint(equalTo: self.centerYAnchor),
        
            label.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 9),
            label.centerXAnchor.constraint(equalTo: icon.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13.5),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13.5)]
        
        NSLayoutConstraint.activate(constraints)
    }

}
