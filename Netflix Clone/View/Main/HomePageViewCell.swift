//
//  HomePageViewCell.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/25/24.
//

import UIKit
import SDWebImage

protocol HomePageViewCellDelegate:AnyObject{
    func ShowingMoviePreviewVC(_ HomePageViewCell:HomePageViewCell, MovieName:String , MovieURL:URL , MovieOverview:String ,MovieBanner:String, Movie_Id:Int)
}

class HomePageViewCell: UITableViewCell {
    
    static let identifier:String = "HomePageViewCell"
    var CollectionView:UICollectionView!
    var CollectionLayout:UICollectionViewFlowLayout!
    var Movies = [HomePageMovieViewModel?]()
    
    var delegate:HomePageViewCellDelegate?
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        CollectionLayout = UICollectionViewFlowLayout()
        CollectionLayout.scrollDirection = .horizontal
        CollectionLayout.itemSize = CGSize(width: 110, height: 170)
        
        CollectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionLayout)
        CollectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: HomePageCollectionViewCell.identifier)
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.showsVerticalScrollIndicator = false
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        self.contentView.addSubview(CollectionView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CollectionView.frame = self.contentView.bounds
    }
    
    public func configure(with movies:[HomePageMovieViewModel]){
        self.Movies = movies
        DispatchQueue.main.async {
            self.CollectionView.reloadData()
        }
    }

}


extension HomePageViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageCollectionViewCell.identifier, for: indexPath) as! HomePageCollectionViewCell
        let image = Movies[indexPath.row]?.image
        cell.configure(image:image ?? " ")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
          return CGSize(width: 110.0, height: 170)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let MovieDetail = Movies[indexPath.row]
        guard let name = MovieDetail?.title , let Overview = MovieDetail?.overview , let Image =  MovieDetail?.image , let Id = MovieDetail?.Movie_Id  else {
            return
        }
        delegate?.ShowingMoviePreviewVC(self, MovieName: name, MovieURL: URL(string: " ")!, MovieOverview: Overview, MovieBanner: Image, Movie_Id: Id)
        
    }
    
    
}

