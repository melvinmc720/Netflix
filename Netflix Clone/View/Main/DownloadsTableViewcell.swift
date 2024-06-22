//
//  DownloadsTableViewcell.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/26/24.
//

import UIKit

class DownloadsTableViewcell: UITableViewCell {

    static let identifier:String = "DownloadsTableViewcell"
    
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
        
        self.MovieImage.frame = CGRect(x: 10, y: 0, width: height / 2, height: height)
        
        self.MovieTitle.frame = CGRect(x: self.MovieImage.frame.maxX + 50, y: 0, width: width - self.MovieImage.frame.width - 150, height: height)
    }
    
    func configure(MovieTitle:String , Image:String){
        self.MovieTitle.text = MovieTitle
        guard let url =  URL(string: "https://image.tmdb.org/t/p/w500/\(Image)") else{
            return
        }
        self.MovieImage.sd_setImage(with: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.MovieTitle.text = "Loading"
        self.MovieImage.image = UIImage(systemName: "person")
    }

}
