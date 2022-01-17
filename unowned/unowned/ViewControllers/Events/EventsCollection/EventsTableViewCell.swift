//
//  EventsTableViewCell.swift
//  unowned
//
//  Created by Misha Causur on 14.12.2021.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    private let eventImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let opaqueView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.image = UIImage(named: "opaque")
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Спонсоры отремонтируют школу-интернат"
        label.font = Font.setFont(.extrabold, 21)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Color.color(.weird)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let flowersView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heart")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Дубовская школа-интернат для детей с ограниченными возможностями здоровья стала первой в области …"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.textColor = Color.color(.darkSlateBlue)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomView: UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.color(.leaf)
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "calendarIcon.png")
        attachment.bounds = CGRect(x: 0, y: -2, width: 14, height: 13)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "   Осталось 13 дней (21.09 – 20.10)")
        myString.insert(attachmentString, at: 0)
        label.attributedText = myString
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ event: CDEvent) {
        eventImage.image = UIImage(named: "kid")
        titleLabel.text = event.name
        descriptionLabel.text = event.disrcrptn
    }
    
    private func setupCell() {
        self.addSubviews(eventImage, opaqueView, titleLabel, flowersView, descriptionLabel, bottomView, dateLabel)
       
        let constraints = [
            eventImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            eventImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            eventImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            eventImage.heightAnchor.constraint(equalToConstant: 231),
            
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: eventImage.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 46),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -46),
            
            opaqueView.leadingAnchor.constraint(equalTo: eventImage.leadingAnchor),
            opaqueView.trailingAnchor.constraint(equalTo: eventImage.trailingAnchor),
            opaqueView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            opaqueView.heightAnchor.constraint(equalToConstant: 141),
            
            flowersView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            flowersView.widthAnchor.constraint(equalToConstant: 112),
            flowersView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            flowersView.heightAnchor.constraint(equalToConstant: 15),
            
            descriptionLabel.topAnchor.constraint(equalTo: flowersView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -23),
            
            bottomView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 31),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dateLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
