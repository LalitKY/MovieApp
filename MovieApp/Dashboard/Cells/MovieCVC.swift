//
//  MovieCVC.swift
//  MovieApp
//
//  Created by Lalit Kant on 17/04/21.
//

import UIKit

protocol FavClicked: class {
    func favClicked(id: Int64)
}

class MovieCVC: UICollectionViewCell {
    
    weak var delegate: FavClicked?
    @IBOutlet private weak var moviePlaceholderImgVw: UIImageView!
    @IBOutlet private weak var movieTitleLbl: UILabel!
    @IBOutlet private weak var favButton: UIButton!
    private var movieData : MovieData!
    
    override func awakeFromNib() {
       moviePlaceholderImgVw.layer.cornerRadius = 5
       super.awakeFromNib()
       //custom logic goes here
    }
    
    @IBAction func favClicked(_ sender: Any) {
        if favButton.isSelected {
            favButton.isSelected = false
            DataManager.shared.favData(movie: movieData)
        } else {
            favButton.isSelected = true
            DataManager.shared.favData(movie: movieData)
        }
        delegate?.favClicked(id: movieData.id)
    }
    
    /// set data for the screen
    /// - Parameters:
    ///    - modal: Movie Data Modal
    func setData(modal: MovieData) {
        movieData = modal
        movieTitleLbl.text = modal.original_title ?? ""
        let imgUrl = EnvironmentHelper.sharedInstance.imagePrefixUrl ?? ""
        let image = String.init(format: "%@%@",imgUrl, (modal.poster_path ?? ""))
        moviePlaceholderImgVw.loadImageUsingCache(withUrl: image,urlMain: URL(string: image)!, nil)
        favButton.isSelected = modal.is_favourited
    }
    
}
