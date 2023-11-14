//
//  DetailViewController.swift
//  ios101-project5-tumblr
//
//  Created by Jhonelle Moore on 11/13/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    var article: Article!
    
    @IBAction func didTapFavorite(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
//        if sender.isSelected {
//            // 1.
//            news.addToFavorites()
//        } else {
//            // 2.
//            news.removeFromFavorites()
//        }
    }
    
    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var descripLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
//    var news: News!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        favorite.layer.cornerRadius = favorite.frame.width / 2
        titleLabel.text = article.title
        descripLabel.text = article.description

//        // 1.
//        let favorites = News.getNews(forkey: News.favoritesKey)
//        // 2.
//        if favorites.contains(news) {
//            // 3.
//            favorite.isSelected = true
//        } else {
//            // 4.
//            favorite.isSelected = false
//        }
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
