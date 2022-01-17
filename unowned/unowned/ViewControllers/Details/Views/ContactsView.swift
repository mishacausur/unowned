//
//  ContactsView.swift
//  unowned
//
//  Created by Misha Causur on 22.12.2021.
//

import UIKit

class ContactsView: UIView {
    
    var event: CDEvent
    private let navIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "navigation")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Санкт-Петербург, Кирочная улица, д. 50А, каб. 208"
        label.numberOfLines = 0
        label.textColor = Color.color(.charcoalGrey)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let phoneIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "phone")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "+7 (937) 037 37-73 \n+7 (937) 016 16-16"
        label.numberOfLines = 0
        label.textColor = Color.color(.charcoalGrey)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let mailIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mail")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let mailLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас есть вопросы?"
        label.numberOfLines = 0
        label.textColor = Color.color(.charcoalGrey)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let linkLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Напишите нам", attributes:
                                                    [.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.numberOfLines = 0
        label.textColor = Color.color(.leaf)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    init(frame: CGRect, event: CDEvent) {
        self.event = event
        super.init(frame: frame)
        self.backgroundColor = .clear
        configureViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func getNumbers(event: CDEvent) -> String {
        var string = String()
        let phones = CoreDataManager.shared.CDgetPhoneNumbers(for: event)
        for item in phones {
            string = "\(item)"
            string += "\n"
        }
        return string
    }
    private func configureViews() {
        self.addSubviews(navIcon, addressLabel, phoneIcon, phoneLabel, mailIcon, mailLabel, linkLabel)
        addressLabel.text = event.address
        phoneLabel.text = getNumbers(event: event)
        let constraints = [
            navIcon.topAnchor.constraint(equalTo: self.topAnchor),
            navIcon.widthAnchor.constraint(equalToConstant: 16),
            navIcon.heightAnchor.constraint(equalTo: navIcon.widthAnchor),
            navIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            addressLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -1),
            addressLabel.leadingAnchor.constraint(equalTo: navIcon.trailingAnchor, constant: 10),
            addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            phoneIcon.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 16),
            phoneIcon.leadingAnchor.constraint(equalTo: navIcon.leadingAnchor),
            phoneIcon.widthAnchor.constraint(equalTo: navIcon.widthAnchor),
            phoneIcon.heightAnchor.constraint(equalTo: navIcon.widthAnchor),
            phoneLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 15),
            phoneLabel.leadingAnchor.constraint(equalTo: phoneIcon.trailingAnchor, constant: 10),
            mailIcon.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 16),
            mailIcon.leadingAnchor.constraint(equalTo: navIcon.leadingAnchor),
            mailIcon.widthAnchor.constraint(equalToConstant: 18),
            mailIcon.heightAnchor.constraint(equalToConstant: 11.1),
            mailLabel.centerYAnchor.constraint(equalTo: mailIcon.centerYAnchor, constant: -1),
            mailLabel.leadingAnchor.constraint(equalTo: mailIcon.trailingAnchor, constant: 10),
            linkLabel.centerYAnchor.constraint(equalTo: mailLabel.centerYAnchor),
            linkLabel.leadingAnchor.constraint(equalTo: mailLabel.trailingAnchor, constant: 1),
            linkLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
}
