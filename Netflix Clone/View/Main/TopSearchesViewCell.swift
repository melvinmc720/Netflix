//
//  TopSearchesViewCell.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/26/24.
//

import UIKit
import SDWebImage

class TopSearchesViewCell: UITableViewCell {
    
    
    static let identifier:String = "TopSearchesViewCell"
    
    var MovieImage:UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(systemName: "house")
        return imageview
        }()
    
    var MovieTitle:UILabel = {
       let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .left
        title.text = "hello milad"
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(MovieImage)
        self.contentView.addSubview(MovieTitle)

    }
    
    required init?(coder: NSCoder) {
        fatalError("You got an Error here")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = self.contentView.frame.height
        let width = self.contentView.frame.width
        
        self.MovieImage.frame = CGRect(x: 20, y: 0, width: height / 2, height: height)
        
        self.MovieTitle.frame = CGRect(x: self.MovieImage.frame.maxX + 50, y: 0, width: width - self.MovieImage.frame.width - 10, height: height)
    }
    
    
    public func configure(_ image:String , _ title:String){
        MovieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(image)"))
        MovieTitle.text = title
    }
    

}
