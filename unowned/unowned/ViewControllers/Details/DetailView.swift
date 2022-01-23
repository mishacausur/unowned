//
//  DetailView.swift
//  unowned
//
//  Created by Misha Causur on 19.12.2021.
//

import Foundation
import UIKit

class DetailView: UIView {
    var event: EventModel
    private let scrollView = UIScrollView(frame: .zero)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.setFont(.extrabold, 21)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = Color.color(.weird)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        label.textColor = Color.color(.grey)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let organizationName: UILabel = {
        let label = UILabel()
        label.text = "Благотворительный фонд «Счастливый Мир»"
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = Color.color(.charcoalGrey)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var contacts = ContactsView(frame: .zero, event: event)
    private let photos = PhotosView()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = Color.color(.charcoalGrey)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let linkLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Перейти на сайт организаии", attributes:
                                                    [.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.numberOfLines = 0
        label.textColor = Color.color(.leaf)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let view = UIView()
    private let stackItems = StackItemsView(frame: .zero, data: Item.items)
    private let facesView = FacesView(frame: .zero)
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "+ 104"
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = Color.color(.grey)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    init(frame: CGRect, event: EventModel) {
        self.event = event
        super.init(frame: frame)
        self.backgroundColor = .white
        configureViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureViews() {
        self.addSubviews(scrollView, view, facesView, moreLabel, stackItems)
        stackItems.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        facesView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.color(.lightGrey)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubviews(titleLabel, dateLabel, organizationName, contacts, photos, descriptionLabel, linkLabel)
        contacts.translatesAutoresizingMaskIntoConstraints = false
        photos.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = event.name
        descriptionLabel.text = event.welcomeDescription
        let contraints = [
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            organizationName.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            organizationName.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contacts.topAnchor.constraint(equalTo: organizationName.bottomAnchor, constant: 18),
            contacts.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contacts.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            photos.topAnchor.constraint(equalTo: contacts.bottomAnchor, constant: 16),
            photos.leadingAnchor.constraint(equalTo: contacts.leadingAnchor),
            photos.trailingAnchor.constraint(equalTo: contacts.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: photos.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            linkLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            linkLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            linkLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -18),
            view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 68),
            view.bottomAnchor.constraint(equalTo: stackItems.topAnchor),
            facesView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            facesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            moreLabel.centerYAnchor.constraint(equalTo: facesView.centerYAnchor),
            moreLabel.leadingAnchor.constraint(equalTo: facesView.trailingAnchor, constant: 10),
            stackItems.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            stackItems.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackItems.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackItems.heightAnchor.constraint(equalToConstant: 70)]
        NSLayoutConstraint.activate(contraints)
    }
}
