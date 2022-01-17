//
//  DetailViewController.swift
//  unowned
//
//  Created by Misha Causur on 19.12.2021.
//

import UIKit

class DetailViewController: UIViewController, ViewControllerable {
    
    typealias RootView = DetailView
    var viewModel: DetailViewOutput
    
    init(viewModel: DetailViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.event.name
        viewModel.viewInput = self
        self.navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = true
    }
   
    override func loadView() {
        let view = DetailView(frame: .zero, event: viewModel.event)
        self.view = view
    }
}

extension DetailViewController: DetailViewInput {
}
