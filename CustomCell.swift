//
//  CustomCell.swift
//  MovieAppSpencer
//
//  Created by RYAN SPENCER on 1/17/25.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell{
    
    @IBOutlet weak var titleOutlet: UILabel!
    
    @IBOutlet weak var infoOutlet: UILabel!
    
    @IBOutlet weak var watchButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    
    func configure(movie: String, year: String){
       
        titleOutlet.text = movie
        infoOutlet.text = year
        if AppData.watchlist.contains(movie) {
            watchButton.imageView!.image = UIImage.init(systemName: "checkmark")
        }
        if AppData.favorites.contains(movie) {
            favButton.imageView!.image = UIImage.init(systemName: "star.fill")
        }
        
    }
    
    @IBAction func watchlistAction(_ sender: UIButton) {
        
//        if watchButton.currentImage!.isEqual(UIImage(named: "plus")) {
//            AppData.watchlist.append(titleOutlet.text!)
//            sender.imageView!.image = UIImage.init(systemName: "checkmark")
//        }
        
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        
//        if favButton.currentImage!.isEqual(UIImage(named: "star")) {
//            AppData.favorites.append(titleOutlet.text!)
//            sender.imageView!.image = UIImage.init(systemName: "star.fill")
//        }
        
    }
    
}
