//
//  SearchResultCollectionViewCell.swift
//  Netflix Clone
//
//  Created by milad marandi on 6/11/24.
//

import UIKit
import SDWebImage

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    static let identifier:String = "SearchResultCollectionViewCell"
    
    let MoviePoster:UIImageView = {
       let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        imageview.image = UIImage(systemName: "house")
        return imageview
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(MoviePoster)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        MoviePoster.frame = contentView.bounds
    }
    
}
