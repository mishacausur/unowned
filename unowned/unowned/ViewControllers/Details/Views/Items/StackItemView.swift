//
//  StackItemView.swift
//  unowned
//
//  Created by Misha Causur on 23.12.2021.
//

import UIKit

final class StackItemsView: UIView {
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 1
        return stack
    }()
    init(frame: CGRect, data: [Item]) {
        super.init(frame: frame)
        configure()
        setup(data: data)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup(data: [Item]) {
        data.forEach { value in
            let view = ItemView()
            let image = UIImage.init(named: value.image)
            view.setData(image!, text: value.label)
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
