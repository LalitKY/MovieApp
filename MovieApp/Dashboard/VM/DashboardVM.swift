//
//  DashboardVM.swift
//  MovieApp
//
//  Created by Lalit Kant on 17/04/21.
//

import Foundation

class DashboardVM {
    var movieResults: Bindable<[MovieData]> = Bindable([])
    var favResults: Bindable<[MovieData]> = Bindable([])
    var movieResultLoadFail: Bindable<Bool> = Bindable(false)
    
    var apiservice = ServiceManager(appData: Service())
    
    init() {
        loadMovies(1)
    }
    
    /// load Movies initially
    /// - Parameters:
    ///    - page: pass page number to load data
    func loadMovies(_ page: Int?) {
        apiservice.fetchNowPlayingMovies(page: page ?? 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let modal):
                DispatchQueue.main.async {
                    self.movieResults.value = modal ?? []
                }
            case .failure(let err) :
                self.movieResultLoadFail.value = true
                print(err)
                break
                
            }
        }
    }
    
    /// load favourite Items
    func loadFavItems()  {
        self.favResults.value = DataManager.shared.fetchFavRocords()
    }
    
}
