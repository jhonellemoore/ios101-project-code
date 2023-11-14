//
//  News.swift
//  ios101-project5-tumblr
//
//  Created by Jhonelle Moore on 11/13/23.
//
//
//  Task.swift
//

import UIKit

struct NewsFeed: Decodable {
    let results: [News]
}
// The Task model
struct News: Codable, Equatable {
    static func == (lhs: News, rhs: News) -> Bool {
        return true
    }
    
    // The news's title
    var title: String
    var description: String

    // A boolean to determine if the task has been completed. Defaults to `false`
    var isComplete: Bool = false {

        // Any time a task is completed, update the completedDate accordingly.
        didSet {
            if isComplete {
                // The task has just been marked complete, set the completed date to "right now".
                completedDate = Date()
            } else {
                completedDate = nil
            }
        }
    }

    // The date the task was completed
    // private(set) means this property can only be set from within this struct, but read from anywhere (i.e. public)
    private(set) var completedDate: Date?

    // The date the task was created
    // This property is set as the current date whenever the task is initially created.
    var createdDate: Date = Date()

    // An id (Universal Unique Identifier) used to identify a task.
    var id: String = UUID().uuidString
}

// MARK: - News + UserDefaults
extension News {

    static var favoritesKey: String {
        return "Favorites"
    }
    
    // Given an array of news, encodes them to data and saves to UserDefaults.
    static func save(_ news: [News], forkey key: String) {
        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(news)
        
        // TODO: Save the array of tasks
        defaults.set(encodedData, forKey: key)
    }

    // Retrieve an array of saved tasks from UserDefaults.
    static func getNews(forkey key: String) -> [News] {
        
        // TODO: Get the array of saved tasks from UserDefaults
        let defaults = UserDefaults.standard
        // 2.
        if let data = defaults.data(forKey: key) {
            // 3.
            let decodedNews = try! JSONDecoder().decode([News].self, from: data)
            // 4.
            return decodedNews
        } else {
            // 5.
            return [] // 👈 replace with returned saved news
        }
    }

    // Add a new task or update an existing task with the current task.
    func save() {
        // TODO: Save the current task
        // 1. Get the array of saved tasks
        var news = News.getNews(forkey: News.favoritesKey)
        let curr = self
        // 2. Check if the current task already exists in the tasks array
        if let index = news.firstIndex(where: { $0.id == curr.id }) {
            // 3. If it exists, update the existing task
            news.remove(at:index)
            news.insert(self, at: index)
            news[index] = curr
        } else {
            // 4. If it doesn't exist, add the new task to the end of the array
            news.append(self)
        }

        // 5. Save the updated tasks array to UserDefaults
        News.save(news, forkey: News.favoritesKey)
    }
    
    // Adds the news to the favorites array in UserDefaults.
    // 1. Get all favorite movies from UserDefaults
    //    - We make `favoriteMovies` a `var` so we'll be able to modify it when adding another movie
    // 2. Add the movie to the favorite movies array
    //   - Since this method is available on "instances" of a movie, we can reference the movie this method is being called on using `self`.
    // 3. Save the updated favorite movies array
    func addToFavorites() {
        // 1.
        var favoriteNews = News.getNews(forkey: News.favoritesKey)
        // 2.
        favoriteNews.append(self)
        // 3.
        News.save(favoriteNews, forkey: News.favoritesKey)
    }

    // Removes the movie from the favorites array in UserDefaults
    // 1. Get all favorite movies from UserDefaults
    // 2. remove all movies from the array that match the movie instance this method is being called on (i.e. `self`)
    //   - The `removeAll` method iterates through each movie in the array and passes the movie into a closure where it can be used to determine if it should be removed from the array.
    // 3. If a given movie passed into the closure is equal to `self` (i.e. the movie calling the method) we want to remove it. Returning a `Bool` of `true` removes the given movie.
    // 4. Save the updated favorite movies array.
    func removeFromFavorites() {
        // 1.
        var favoriteNews = News.getNews(forkey: News.favoritesKey)
        // 2.
        favoriteNews.removeAll { news in
            // 3.
            return self == news
        }
        // 4.
        News.save(favoriteNews, forkey: News.favoritesKey)
    }
}
