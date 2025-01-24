//
//  InfoViewController.swift
//  MovieAppSpencer
//
//  Created by RYAN SPENCER on 1/24/25.
//

import UIKit

struct Movie: Codable {
    
    var Actors: String
    var Year: String
    var Director: String
    var Genre: String
    var Awards: String
    
}

class InfoViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = AppData.currentMovie
    }

}
