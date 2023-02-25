//
//  ViewController.swift
//  PlayTime
//
//  Created by Martín Sande on 24/2/23.
//

import UIKit
import PTClient
import PTDesignSystem

final class Home: UIViewController {
    private lazy var grid: PTCatalogGrid = .init(router: self.navigationController as? PTNavigationController)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        grid.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(grid)
    }
}
