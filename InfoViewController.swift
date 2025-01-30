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
    var Poster: String
    
}

class InfoViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var textViewOutlet: UITextView!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var watchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = AppData.currentMovie
        getMovie(AppData.currentMovie)
        for movie in AppData.favorites {
            if movie == AppData.currentMovie{
                favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                break
            }
        }
        for movie in AppData.watchlist {
            if movie == AppData.currentMovie{
                watchButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                break
            }
        }
    }
    
    func getMovie(_ movie: String){
        
        let session = URLSession.shared
        let url = URL(string: "http://www.omdbapi.com/?i=tt3896198&apikey=78557f93&type=movie&t=\(movie)")
        let dataTask = session.dataTask(with: url!){ data, response, error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: "Movie not found.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                return
            } else {
                if let d = data {
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .fragmentsAllowed) as? NSDictionary{
                        if jsonObj.value(forKey: "Error") as? String == "Movie not found!"{
                            let alert = UIAlertController(title: "Error", message: "Movie not found.", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            alert.addAction(okAction)
                            DispatchQueue.main.async {
                                self.present(alert, animated: true, completion: nil)
                            }
                            return
                        }
                        print(jsonObj)
                        //get Movie object with JSONDecoder
                        if let movieObj = try? JSONDecoder().decode(Movie.self, from: d){
                            DispatchQueue.main.async {
                                self.textViewOutlet.text = "Year: \(movieObj.Year)\nActors: \(movieObj.Actors)\nDirector: \(movieObj.Director)\nGenre: \(movieObj.Genre)\nAwards: \(movieObj.Awards)"
                                self.imageOutlet.image = UIImage(named: movieObj.Poster)
                            }
                        } else{
                            print("error decoding to movie object")
                        }
                    } else {
                        print("json object is nil")
                    }
                } else {
                    print("No data")
                }
            }
        }
        
        dataTask.resume()
        
    }
    
    
    @IBAction func favAction(_ sender: UIButton) {
        if favButton.image(for: .normal) == UIImage(systemName: "star") {
            AppData.favorites.append(titleLabel.text!)
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
            for i in 0...AppData.favorites.count {
                if AppData.favorites[i] == AppData.currentMovie {
                    AppData.favorites.remove(at: i)
                    break
                }
            }
        }
    }
    
    @IBAction func watchAction(_ sender: UIButton) {
        if watchButton.image(for: .normal) == UIImage(systemName: "plus") {
            AppData.watchlist.append(titleLabel.text!)
            watchButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else {
            watchButton.setImage(UIImage(systemName: "plus"), for: .normal)
            for i in 0...AppData.watchlist.count {
                if AppData.watchlist[i] == AppData.currentMovie {
                    AppData.watchlist.remove(at: i)
                    break
                }
            }
        }
    }
    
}
