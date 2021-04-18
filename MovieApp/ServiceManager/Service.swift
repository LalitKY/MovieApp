

import Foundation

// Protocol to get data from api
protocol GetAppData {
    func fetchMovies(pageNo: Int?, completion: @escaping (Result<NowPlayingMovieModal?, Error>) -> ())
}

// This class responsible for fetching data from api and getting secured api data as well.
class Service: GetAppData {
        
    private let appUrl: String!
    private let apiKey: String!
    
    init () {
        appUrl = EnvironmentHelper.sharedInstance.appUrl ?? ""
        apiKey = EnvironmentHelper.sharedInstance.apiKey ?? ""
    }
    
    /// load Movies IOC
    /// - Parameters:
    ///    - pageNo: pass page number to load data
    ///    - completion: competion handler return Result<NowPlayingMovieModal?, Error>
    func fetchMovies(pageNo: Int?, completion: @escaping (Result<NowPlayingMovieModal?, Error>) -> ()) {
        let urlString = "\(String(describing: appUrl!))?page=\(String(describing: pageNo!))&api_key=\(String(describing: apiKey!))"
        NetCom().fetchGenericJSONData(urlString: urlString, completion: completion)
    }
}
