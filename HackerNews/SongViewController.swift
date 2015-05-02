//
//  SongViewController.swift
//  HackerNews
//
//  Created by Alex Choi on 5/2/15.
//  Copyright (c) 2015 Alex Choi. All rights reserved.
//

import StreamingKit
import SnapKit


class SongViewController: UIViewController {
    

    let audioPlayer = STKAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.greenColor()
        
        audioPlayer.play("http://www.abstractpath.com/files/audiosamples/sample.mp3")
        
        
        
    }
    
}
