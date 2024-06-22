//
//  HomePageHeaderView.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/25/24.
//

import UIKit
import AVKit
import AVFoundation

protocol HomePageHeaderViewVideoPlay:AnyObject{
    func PlayVideoAgain(_ Player:AVPlayer)
}


class HomePageHeaderView: UITableViewHeaderFooterView {
    static let identifier:String = "HomePageHeaderView"
    
    var player:AVPlayer?
    var PlayerLayer:AVPlayerLayer!
    var delegate:HomePageHeaderViewVideoPlay?
    
    let MovieBanner:UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 10
        imageView.layer.shadowOffset = CGSize(width: 15, height: 15)
        imageView.layer.shadowRadius = 10
        imageView.layer.masksToBounds = false
        return imageView
        
    }()
    
    let PlayButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Play", for: .normal)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    let DownloadButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Download", for: .normal)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubview(MovieBanner)
        self.addSubview(PlayButton)
        self.addSubview(DownloadButton)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [self] in
            MovieBanner.isHidden = true
            HeaderTrailer()
        })
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(PauseVideo), name: NSNotification.Name("PauseVideo"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PlayVideo), name: NSNotification.Name("PlayVideo"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReplayVideo), name: NSNotification.Name("ReplayVideo"), object: nil)
        
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        let spaceBetweenButtons = CGFloat(40)
        MovieBanner.frame = self.contentView.bounds
        PlayButton.frame = CGRect(x: self.contentView.center.x - self.PlayButton.frame.width - spaceBetweenButtons , y: self.contentView.frame.maxY - 40, width: 110, height: 35)
        
        DownloadButton.frame = CGRect(x: self.contentView.center.x + spaceBetweenButtons , y: self.contentView.frame.maxY - 40, width: 110, height: 35)
        
        
    }
    
    
    public func HeaderTrailer(){
        guard let TrailerPath = Bundle.main.path(forResource: "Trailer", ofType: "mp4") else{
            print("error")
            return
        }
        player = AVPlayer(url:URL(fileURLWithPath: TrailerPath))
        player?.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        PlayerLayer = AVPlayerLayer(player: player)
        PlayerLayer.frame = self.contentView.bounds
        PlayerLayer.videoGravity = .resizeAspectFill
        self.contentView.layer.addSublayer(PlayerLayer)
        player?.volume = 0.0
        player?.play()
        NotificationCenter.default.addObserver(self, selector: #selector(Replay), name: AVPlayerItem.didPlayToEndTimeNotification, object: player?.currentItem)
    }
    
    
    @objc func Replay(){
        player?.seek(to: .zero)
        player?.play()
    }
    
    deinit {
           // Remove observer and cleanup
           NotificationCenter.default.removeObserver(self, name: AVPlayerItem.didPlayToEndTimeNotification, object: player)
           player?.pause()
           PlayerLayer?.removeFromSuperlayer()
           player = nil
           PlayerLayer = nil
       }
    
}

// -MARK: VIDEO PLAYER STATUS
extension  HomePageHeaderView{
    
    @objc func PauseVideo(){
        if player?.timeControlStatus == .playing {
            player?.pause()
        }
    }
    @objc func PlayVideo(){
        if player?.timeControlStatus == .paused {
            player?.play()
        }
    }
    
    @objc func ReplayVideo(){
        if player?.timeControlStatus == .playing {
            player?.seek(to: .zero)
            player?.play()
        }
    }
    
    
}
