//
//  ViewController.swift
//  MovieApp
//
//  Created by Lalit Kant on 17/04/21.
//

import UIKit

enum FavEnum {
    case selected
    case unSelected
}

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let vm = DashboardVM()
    private var selectfavButton = FavEnum.unSelected
    
    override func viewDidLoad() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //this is for direction
        layout.minimumInteritemSpacing = 20 // this is for spacing between cells
        layout.itemSize = CGSize(width: view.frame.width/2-10, height: view.frame.width/2-10)
        collectionView.collectionViewLayout = layout
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bindedViewModals()
        super.viewDidAppear(true)
    }
    
    @IBAction func filterByFav(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            selectfavButton = FavEnum.unSelected
        } else {
            vm.loadFavItems()
            sender.isSelected = true
            selectfavButton = FavEnum.selected
        }
        self.updateUI()
    }
    
}

private extension ViewController {
    
    /// Keep all bindable object in single place
    
    func bindedViewModals() {
        self.vm.movieResults.bind { (returnValue) in
            self.updateUI()
        }
        self.vm.movieResultLoadFail.bind { (returnValue) in
            self.updateUI()
        }
        self.vm.favResults.bind { (returnValue) in
            self.updateUI()
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectfavButton == FavEnum.unSelected {
            return vm.movieResults.value.count
        }
        return vm.favResults.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CellConstants.moveiCellID, for: indexPath) as! MovieCVC
        var modeldata: MovieData
        if selectfavButton == FavEnum.unSelected {
            modeldata = vm.movieResults.value[indexPath.row]
        } else {
            modeldata = vm.favResults.value[indexPath.row]
        }
        cell.setData(modal: modeldata)
        cell.delegate = self
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ViewController: FavClicked {
    func favClicked(id: Int64) {
        if selectfavButton == FavEnum.selected {
            vm.loadFavItems()
        }
    }
}
