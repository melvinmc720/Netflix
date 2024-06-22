//
//  HomePageSectionTitleHeaderView.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 6/13/24.
//

import UIKit

class HomePageSectionTitleHeaderView: UITableViewHeaderFooterView {
    
    
    static let identifier:String = "HomePageSectionTitleHeaderView"
    
    private var SectionTitle:UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(SectionTitle)
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        SectionTitle.frame = self.contentView.frame
    }
    
    public func Title(with Section:String){
        self.SectionTitle.text = Section
    }
    
    

}
