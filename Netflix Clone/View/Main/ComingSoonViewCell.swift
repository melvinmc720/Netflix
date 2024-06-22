//
//  ComingSoonViewCell.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/26/24.
//

import UIKit

import SDWebImage

class ComingSoonViewCell: UITableViewCell {
    
    static let identifier:String = "ComingSoonViewCell"
    
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
        return title
    }()
    
    var PlayButton:UIButton = {
       let button = UIButton()
        var image = UIImage(systemName: "play.circle" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleToFill
 
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(MovieImage)
        self.contentView.addSubview(MovieTitle)
        self.contentView.addSubview(PlayButton)

    }
    
    required init?(coder: NSCoder) {
        fatalError("You got an Error here")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = self.contentView.frame.height
        let width = self.contentView.frame.width
        
        self.MovieImage.frame = CGRect(x: 20, y: 0, width: height / 2, height: height)
        
        self.MovieTitle.frame = CGRect(x: self.MovieImage.frame.maxX + 50, y: 0, width: width - self.MovieImage.frame.width - 150, height: height)
        
        self.PlayButton.frame = CGRect(x: self.MovieTitle.frame.maxX + 5, y: 0, width: height - 20, height: height - 20)
        self.PlayButton.layer.masksToBounds = true
        self.PlayButton.layer.cornerRadius = (height - 20)/2
        self.PlayButton.center.y = self.contentView.center.y
    }
    
    public func configure(name:String , poster:String){
        self.MovieTitle.text = name
        self.MovieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(poster)"))
    }

}
