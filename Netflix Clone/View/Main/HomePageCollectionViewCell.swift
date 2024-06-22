//
//  HomePageCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/25/24.
//

import UIKit


class HomePageCollectionViewCell: UICollectionViewCell {
    
    static let identifier:String = "HomePageCollectionViewCell"
    
    var imageView:UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(systemName: "person")
        return imageview
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.contentView.frame
    }
    
    public func configure(image:String){
        self.imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(image)"))
    }
}
