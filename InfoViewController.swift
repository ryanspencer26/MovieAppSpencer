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
        getMovie(AppData.currentMovie)
    }
    
    func getMovie(_ movie: String){
        
        let session = URLSession.shared
        let url = URL(string: "http://www.omdbapi.com/?i=tt3896198&apikey=78557f93&t=\(movie)")
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
                        if let year = jsonObj.value(forKey: "Year"){
                            print("\(movie) was released in \(year)")
                            DispatchQueue.main.async {
                                //textField
                            }
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
    

}
