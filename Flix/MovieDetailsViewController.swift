//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Alvis Chan on 9/19/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisTextView: UITextView!
    
    var movie: [String: Any]!
    override func viewDidLoad() {
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisTextView.text = movie["overview"] as? String
        //synopsisTextView.sizeToFit()
        posterImageView.af.setImage(withURL: URL(string: ("https://image.tmdb.org/t/p/original" + (movie["poster_path"] as! String)))!)
        backdropImageView.af.setImage(withURL: URL(string: ("https://image.tmdb.org/t/p/original" + (movie["backdrop_path"] as! String)))!)
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
