//
//  DownloadingAnimation.swift
//  Netflix Clone
//
//  Created by milad marandi on 6/18/24.
//

import Foundation
import UIKit
import JGProgressHUD

func DownloadingAnimation(_ view:UIView){
    
    let HUD = JGProgressHUD()
    HUD.indicatorView = JGProgressHUDPieIndicatorView()
    HUD.textLabel.text = "Downloading"
    HUD.detailTextLabel.text = "0%"
    HUD.show(in: view)
    
    var progress:Float = 0.0
    
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
        progress += 0.1
        HUD.setProgress(progress, animated: true)
        let value = Int((progress / 1.0) * 100)
        HUD.detailTextLabel.text = "\(value)%"
        if progress > 1.0{
            timer.invalidate()
            HUD.dismiss(afterDelay: 1.5)
        }
    })
    
}
