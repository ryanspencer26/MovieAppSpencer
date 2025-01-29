//
//  SearchViewController.swift
//  MovieAppSpencer
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [String]()
    var years = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getMovie(_ movie: String){
        
        let session = URLSession.shared
        let url = URL(string: "http://www.omdbapi.com/?i=tt3896198&apikey=78557f93&type=movie&r=json&s=\(movie)")
        let dataTask = session.dataTask(with: url!){ data, response, error in
            if error != nil{
                print("Error")
                return
            } else {
                if let d = data {
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .fragmentsAllowed) as? NSDictionary{
                        if let movies = jsonObj.value(forKey: "Search") as? [NSDictionary]{
                            print(movies)
                            for movie in movies{
                                self.movies.append(movie.value(forKey: "Title")! as! String)
                                self.years.append(movie.value(forKey: "Year")! as! String)
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! CustomCell
        cell.configure(movie: movies[indexPath.row], year: years[indexPath.row])
        return cell
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.movies = [String]()
        self.years = [String]()
        if searchField.text != "" && searchField.text != "The" {
            getMovie(searchField.text!)
            tableView.reloadData()
        } else {
            let alert = UIAlertController(title: "Error", message: "Movie not found.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppData.currentMovie = movies[indexPath.row]
        performSegue(withIdentifier: "movieInfo", sender: self)
    }
    
}
