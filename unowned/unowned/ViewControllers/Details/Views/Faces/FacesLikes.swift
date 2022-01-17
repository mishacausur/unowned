//
//  FacesLikes.swift
//  unowned
//
//  Created by Misha Causur on 23.12.2021.
//

import UIKit

class FacesLikes: UIView {
    
    private let face: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 18
        image.layer.masksToBounds = true
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func getImage(_ name: String) {
        face.image = UIImage(named: name)
    }
    private func configureViews() {
        self.addSubview(face)
        [face.topAnchor.constraint(equalTo: self.topAnchor),
         face.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         face.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         face.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         face.widthAnchor.constraint(equalToConstant: 36),
         face.heightAnchor.constraint(equalTo: face.widthAnchor)].forEach { $0.isActive = true }
    }
}
