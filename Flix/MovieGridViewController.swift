//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Alvis Chan on 9/19/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var movieGridCollectionView: UICollectionView!
    
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        movieGridCollectionView.dataSource = self
        movieGridCollectionView.delegate = self
        let layout = movieGridCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let width = view.frame.size.width / 2 - 2.5
        layout.itemSize = CGSize(width: width, height: (width*7)/5)
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 1000)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.movieGridCollectionView.reloadData()
             }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieGridCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridViewCell", for: indexPath) as! MovieGridViewCell
        cell.posterImageView.af.setImage(withURL: URL(string: ("https://image.tmdb.org/t/p/original" + (movies[indexPath.item]["poster_path"] as! String)))!)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movies[movieGridCollectionView.indexPath(for: sender as! UICollectionViewCell)!.item]
        //tableView.deselectRow(at: movieGridCollectionView.indexPath(for: sender as! UICollectionViewCell)!, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
