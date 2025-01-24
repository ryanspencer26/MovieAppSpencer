//
//  ViewController.swift
//  MovieAppSpencer
//
//  Created by RYAN SPENCER on 1/15/25.
//

import UIKit

class AppData: Codable {
    
    static var watchlist = [String]()
    static var favorites = [String]()
    static var currentMovie: String!
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

