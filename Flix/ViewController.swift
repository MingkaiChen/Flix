//
//  ViewController.swift
//  Flix
//
//  Created by Alvis Chan on 9/19/21.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 1000)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.tableView.reloadData()
             }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell;
        
        cell.titleLabel.text = movies[indexPath.row]["title"] as? String
        cell.synopsisLabel.text = movies[indexPath.row]["overview"] as? String
        cell.posterView.af.setImage(withURL: URL(string: ("https://image.tmdb.org/t/p/w154" + (movies[indexPath.row]["poster_path"] as! String)))!)
        
        
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsViewController = segue.destination as! MovieDetailsViewController
//        detailsViewController.titleLabel.text = movies[tableView.indexPath(for: sender as! UITableViewCell)!.row]["title"] as! String
//        detailsViewController.synopsisLabel.text = movies[tableView.indexPath(for: sender as! UITableViewCell)!.row]["overview"] as! String
//        detailsViewController.posterImageView.af.setImage(withURL: URL(string: ("https://image.tmdb.org/t/p/w154" + (movies[tableView.indexPath(for: sender as! UITableViewCell)!.row]["poster_path"] as! String)))!)
        detailsViewController.movie = movies[tableView.indexPath(for: sender as! UITableViewCell)!.row]
        tableView.deselectRow(at: tableView.indexPath(for: sender as! UITableViewCell)!, animated: true)
    }

}

