//
//  MoviePreViewViewController.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 6/13/24.
//

import UIKit
import WebKit
import AVKit
import AVFoundation




class MoviePreViewViewController: UIViewController {
    
    
    
    
    private var MovieURL:URL?
    private var MovieID:Int = 0
    
    
    private let MovieBanner:UIImageView  = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(systemName: "person")

        return image
    }()
    
    private let MovieOverview:UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .justified
        label.textColor = .label
        label.numberOfLines = .max
        label.text = "hello milad how are you , are you doing well?"
        return label
    }()
    
    
    private let WatchTrailer:UIButton = {
        let button = UIButton()
        button.setTitle("Watch Trailer", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(WatchingTrailer), for: .touchUpInside)
        return button
    }()
    
    private let DownloadButton:UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(DownloadMovie), for: .touchUpInside)
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle:nil)
    }
   
    convenience init(MovieName:String , MovieURL:URL? , MovieOverview:String , MovieBanner:String , Movie_Id:Int){
        self.init()
        self.MovieOverview.text = MovieOverview
        self.title = MovieName
        self.MovieURL = MovieURL
        self.MovieBanner.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(MovieBanner)"))
        self.MovieID = Movie_Id
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        view.addSubview(MovieBanner)
        view.addSubview(MovieOverview)
        view.addSubview(WatchTrailer)
        view.addSubview(DownloadButton)
        
        self.MovieBanner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.MovieBanner.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.MovieBanner.widthAnchor.constraint(equalToConstant: self.view.frame.width - 20),
            self.MovieBanner.heightAnchor.constraint(equalToConstant: 250),
            self.MovieBanner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
         ])
        
        

    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.MovieOverview.frame  = CGRect(x:0,y:self.MovieBanner.frame.maxY + 10,width: self.MovieBanner.frame.width, height: self.MovieBanner.frame.height - 50)
        self.MovieOverview.center.x = self.view.center.x
        
        self.WatchTrailer.frame = CGRect(x: 0, y: self.MovieOverview.frame.maxY + 10, width: 200, height: 50)
        self.WatchTrailer.center.x = self.view.center.x - (self.WatchTrailer.frame.width / 2) - 5
        
        self.DownloadButton.frame = CGRect(x: self.WatchTrailer.frame.maxX + 5, y: self.WatchTrailer.frame.minY, width: 200, height: 50)
        
        
        
    }
    
    @objc func WatchingTrailer(_ Button:UIButton){
        
    }
    
    @objc func DownloadMovie(_ Button:UIButton){
        DownloadingAnimation(view)
        APIcaller.shared.DownloadMovie(Media_ID: self.MovieID) { result in
            switch result{
            case .success(_):
                print("success")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("UpdateView"), object: nil)
                }
            case .failure(_):
                print("failure")
            }
        }
    }
    
    
    
    
    

}
