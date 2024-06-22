//
//  NetflixIconView.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/26/24.
//

import UIKit

class NetflixIconView: UIView {
    
    let ImageView:UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "Netflix")
        imageview.contentMode = .scaleToFill
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(ImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ImageView.frame = self.bounds
        ImageView.center = self.center
    }
    
}
