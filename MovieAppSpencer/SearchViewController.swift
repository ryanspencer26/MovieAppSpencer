//
//  SearchViewController.swift
//  MovieAppSpencer
//
//  Created by RYAN SPENCER on 1/16/25.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getMovie("Blade")
    }
    
    func getMovie(_ movie: String){
        
        let session = URLSession.shared
        let url = URL(string: "http://www.omdbapi.com/?i=tt3896198&apikey=78557f93&s=\(movie)")
        let dataTask = session.dataTask(with: url!){ data, response, error in
            if error != nil{
                print("Error")
                return
            } else {
                if let d = data {
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .fragmentsAllowed) as? NSDictionary{
                        print(jsonObj)
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
