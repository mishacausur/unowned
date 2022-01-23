//
//  PhotosView.swift
//  unowned
//
//  Created by Misha Causur on 22.12.2021.
//

import UIKit

class PhotosView: UIView {
    
    private let photo1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "kid")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let photo2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "kid")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let photo3: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "kid")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        configureViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureViews() {
        self.addSubviews(photo1, photo2, photo3)
        let constraints = [
            photo1.topAnchor.constraint(equalTo: self.topAnchor),
            photo1.widthAnchor.constraint(equalToConstant: 222),
            photo1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photo1.heightAnchor.constraint(equalToConstant: 160),
            photo1.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photo2.topAnchor.constraint(equalTo: self.topAnchor),
            photo2.leadingAnchor.constraint(equalTo: photo1.trailingAnchor, constant: 10),
            photo2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photo2.heightAnchor.constraint(equalToConstant: 79),
            photo3.topAnchor.constraint(equalTo: photo2.bottomAnchor, constant: 10),
            photo3.leadingAnchor.constraint(equalTo: photo1.trailingAnchor, constant: 10),
            photo3.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photo3.bottomAnchor.constraint(equalTo: photo1.bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
    }

}
