//
//  ServiceManager.swift
//  MovieApp
//
//  Created by Lalit Kant on 17/04/21.
//

import Foundation

// This class hold IOC concept to make code loosly coupled between VM, Network and datamanger class
class ServiceManager {
    
    var data: GetAppData
    let util = Utility()
    
    init(appData: GetAppData) {
        self.data = appData
    }
    ///Main logic. We can extend it as well in future for pagination
    /// This is main method to handle all api response to handle page responses and this method have logic if api storage timeout expired then we clear DB and fetch data from start.
    func fetchNowPlayingMovies(page: Int, completion: @escaping (Result<[MovieData]?, Error>) -> ()) {
        if util.apiTimeTimeout() == false || DataManager.shared.currentDataPage == page {
            do {
                let moviewData = try DataManager.shared.fetchAllRecords()
                completion(.success(moviewData))
            } catch  {
                completion(.success([MovieData]()))
            }
            return
        } else if util.apiTimeTimeout() == true {
            do {
                try DataManager.shared.clearMovieDataEntity()
            } catch  {            }
        }
        loadMovies(page: page, completion: completion)
    }
    
    /// load Movies IOC
    /// - Parameters:
    ///    - page: pass page number to load data
    ///    - completion: competion handler return Result<[MovieData]?, Error>
    private func loadMovies(page: Int, completion: @escaping (Result<[MovieData]?, Error>) -> ()) {
        data.fetchMovies(pageNo: page) { (result) in
            switch result {
            case .success(let modal):
                self.util.setTimeOutTime()
                DataManager.shared.saveMoviesToDB(object: modal)
                do {
                    let moviewData = try DataManager.shared.fetchRecordsWithPage(page: page)
                    completion(.success(moviewData))
                } catch  {
                    completion(.success([MovieData]()))
                }
                break
            case .failure(let err) :
                completion(.failure(err))
                print(err)
                break
            }
        }
    }
    
}






