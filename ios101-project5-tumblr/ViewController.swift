//
//  ViewController.swift
//  ios101-lab5-flix1
//

import UIKit
import Nuke

// TODO: Add table view data source conformance
class ViewController: UIViewController, UITableViewDataSource {
    // A property to store the movies we fetch.
    // Providing a default value of an empty array (i.e., `[]`) avoids having to deal with optionals.
    private var articles: [Article] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows for the table.
        print("🍏 numberOfRowsInSection called with movies count: \(articles.count)")
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create, configure, and return a table view cell for the given row (i.e., `indexPath.row`)

           print("🍏 cellForRowAt called for row: \(indexPath.row)")

           // Get a reusable cell
           // Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table. This helps optimize table view performance as the app only needs to create enough cells to fill the screen and reuse cells that scroll off the screen instead of creating new ones.
           // The identifier references the identifier you set for the cell previously in the storyboard.
           // The `dequeueReusableCell` method returns a regular `UITableViewCell`, so we must cast it as our custom cell (i.e., `as! MovieCell`) to access the custom properties you added to the cell.
           let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell

           // Get the movie associated table view row
           let article = articles[indexPath.row]

           // Configure the cell (i.e., update UI elements like labels, image views, etc.)

           // Set the text on the labels
           cell.titleLabel.text = article.title
           cell.descripLabel.text = article.description

           // Return the cell for use in the respective table view row
           return cell
    }
    


    // TODO: Add table view outlet
    
    @IBOutlet weak var tableView: UITableView!
    

    // TODO: Add property to store fetched movies array


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        // TODO: Assign table view data source


        fetchArticles()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }

        // Get the selected movie from the movies array using the selected index path's row
        let selectedArticle = articles[selectedIndexPath.row]

        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
        guard let detailViewController = segue.destination as? DetailViewController else { return }

        detailViewController.article = selectedArticle
    }

    // Fetches a list of popular movies from the TMDB API
    private func fetchArticles() {

        // URL for the TMDB Get Popular movies endpoint: https://developers.themoviedb.org/3/movies/get-popular-movies
        let url = URL(string: "https://newsdata.io/api/1/news?apikey=pub_327951b4249c4e115f94da1d74863ff19f600&q=jamaica&country=jm")!

        // ---
        // Create the URL Session to execute a network request given the above url in order to fetch our movie data.
        // https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory
        // ---
        let session = URLSession.shared.dataTask(with: url) { data, response, error in

            // Check for errors
            if let error = error {
                print("🚨 Request failed: \(error.localizedDescription)")
                return
            }

            // Check for server errors
            // Make sure the response is within the `200-299` range (the standard range for a successful response).
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("🚨 Server Error: response: \(String(describing: response))")
                return
            }

            // Check for data
            guard let data = data else {
                print("🚨 No data returned from request")
                return
            }

            // The JSONDecoder's decode function can throw an error. To handle any errors we can wrap it in a `do catch` block.
            do {

                // Decode the JSON data into our custom `MovieResponse` model.
                let articleResponse = try JSONDecoder().decode(ArticleResponse.self, from: data)

                // Access the array of movies
                let articles = articleResponse.results

                // Run any code that will update UI on the main thread.
                DispatchQueue.main.async { [weak self] in

                    // We have movies! Do something with them!
                    print("✅ SUCCESS!!! Fetched \(articles.count) movies")

                    // Iterate over all movies and print out their details.
                    for article in articles {
                        print("🍿 ARTICLE ------------------")
                        print("Title: \(article.title)")
                        print("Description: \(article.description)")
                    }

                    // TODO: Store movies in the `movies` property on the view controller
                    self?.articles = articles
                    self?.tableView.reloadData()
                    print("🍏 Fetched and stored \(articles.count) movies")


                }
            } catch {
                print("🚨 Error decoding JSON data into Movie Response: \(error.localizedDescription)")
                return
            }
        }

        // Don't forget to run the session!
        session.resume()
    }


}
