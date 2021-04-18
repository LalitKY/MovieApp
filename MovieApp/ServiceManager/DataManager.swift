//
//  DataManager.swift
//  MovieApp
//
//  Created by Lalit Kant on 18/04/21.
//

import Foundation
import CoreData

// This Snigalon class is responsible to do CRUD operation on CoreData over Movie data.
final class DataManager {
    
    static let shared = DataManager()
    var currentDataPage = -1
    
    private init() {    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MovieApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /// Clear Movie data entity
    func clearMovieDataEntity() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MovieData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try self.context.execute(deleteRequest)
        try self.context.save()
    }
    
}

// MARK: - Save operation
extension DataManager {
    func saveMoviesToDB(object : NowPlayingMovieModal?) {
        guard object != nil  else {
            return
        }
        insertRecordsToDB(object: object!)
        currentDataPage = object?.page ?? 1
    }
    
    private func insertRecordsToDB(object : NowPlayingMovieModal) {
        let date = Date.init()
        guard let nowPlayingMovieResults = object.results else {
            return
        }
        for movieDetail in nowPlayingMovieResults {
            let movie = MovieData(context: self.context)
            movie.is_favourited = false
            movie.cache_time_out =  date
            movie.page = Int64(object.page ?? 0)
            movie.total_pages = Int64(object.total_pages ?? 0)
            movie.total_results = Int64(object.total_results ?? 0)
            movie.overview = movieDetail.overview ?? ""
            movie.original_title = movieDetail.original_title ?? ""
            movie.poster_path = movieDetail.poster_path ?? ""
            movie.id = Int64(movieDetail.id ?? 0)
            saveContext()
        }
    }
}

// MARK: - Fetch operation
extension DataManager {
    func fetchAllRecords() throws -> [MovieData] {
        let movies = try self.context.fetch(MovieData.fetchRequest() as NSFetchRequest<MovieData>)
        return movies
    }
    
    func fetchRecordsWithPage(page: Int) throws -> [MovieData] {
        let request = NSFetchRequest<MovieData>(entityName: "MovieData")
        request.predicate = NSPredicate(format: "page == %d", page)
        let movies = try self.context.fetch(request)
        return movies
    }
    
    func fetchFavRocords() -> [MovieData] {
        do {
           return try fetchRecordsWithFavouratedIsSelected()
        } catch  {
            return [MovieData]()
        }
    }
    
    private func fetchRecordsWithFavouratedIsSelected() throws -> [MovieData] {
        let request = NSFetchRequest<MovieData>(entityName: "MovieData")
        request.predicate = NSPredicate(format: "is_favourited == %d", true)
        let movies = try self.context.fetch(request)
        return movies
    }
}

// MARK: - Favourite operation
extension DataManager{
    func favData(movie: MovieData) {
        do {
            try favouriteRecord(movie: movie)
        } catch  {
            print("record not saved")
        }
    }
        
    private func favouriteRecord(movie: MovieData) throws {
        let request = NSFetchRequest<MovieData>(entityName: "MovieData")
        request.predicate = NSPredicate(format: "id == %d", movie.id)
        let movies = try self.context.fetch(request)
        if movies.count > 0 {
            movies[0].is_favourited = !movies[0].is_favourited
        }
        try self.context.save()
    }
}
