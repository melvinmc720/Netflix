//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 6/6/24.
//

import UIKit
import SDWebImage


protocol SearchResultViewControllerDelegate:AnyObject{
    func ShowingMoviePreviewVC(_ HomePageViewCell:SearchResultViewController, MovieName:String , MovieURL:URL? , MovieOverview:String ,MovieBanner:String, Movie_Id:Int)
}

class SearchResultViewController: UIViewController {
    
    var CollectionView:UICollectionView!
    var CollectionViewLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var Movies = [SearchResultViewModel]()
    
    var delegate:SearchResultViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionViewLayout.scrollDirection = .vertical
        CollectionViewLayout.itemSize = CGSize(width: view.frame.width/3.5, height: 200)
        CollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        CollectionViewLayout.minimumLineSpacing = 15
        CollectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout)
        CollectionView.delegate = self
        CollectionView.dataSource = self
        CollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        
        view.addSubview(CollectionView)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CollectionView.frame = view.frame
    }
    

}


extension SearchResultViewController:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        let movie = Movies[indexPath.row]
        cell.MoviePoster.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.Poster)"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = Movies[indexPath.row]
        
        delegate?.ShowingMoviePreviewVC(self, MovieName: movie.Title, MovieURL: nil, MovieOverview: movie.Overview, MovieBanner: movie.Poster, Movie_Id: movie.Id)
    }
    
    
}
