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
        
        if watchButton.image(for: .normal) == UIImage(systemName: "plus") {
            AppData.watchlist.append(titleOutlet.text!)
            watchButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else {
            watchButton.setImage(UIImage(systemName: "plus"), for: .normal)
            //remove from watchlist
        }
        
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        
        if favButton.image(for: .normal) == UIImage(systemName: "star") {
            AppData.favorites.append(titleOutlet.text!)
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
            //remove from favorites
        }
        
    }
    
}
