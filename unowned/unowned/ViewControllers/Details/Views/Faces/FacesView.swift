//
//  FacesView.swift
//  unowned
//
//  Created by Misha Causur on 23.12.2021.
//

import UIKit

final class FacesView: UIView {
    
    let faces = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = -5
        return stack
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setup(data: faces)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup(data: [String]) {
        data.forEach { value in
            let view = FacesLikes()
            view.getImage(value)
            stackView.addArrangedSubview(view)
        }
    }
    private func configure() {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        [stackView.topAnchor.constraint(equalTo: self.topAnchor),
         stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)].forEach { $0.isActive = true }
    }
}
