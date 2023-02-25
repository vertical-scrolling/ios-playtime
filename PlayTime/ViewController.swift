//
//  ViewController.swift
//  PlayTime
//
//  Created by Martín Sande on 24/2/23.
//

import UIKit
import PTClient
import PTDesignSystem

final class ViewController: UIViewController {
    private let grid: PTCatalogGrid = .initForAutolayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(grid)
    }
}
