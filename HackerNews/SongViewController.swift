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
    
    

    
    let mapView = AGSMapView()
    let baseMapTiledLayerName = "baseMapTiledLayerName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.greenColor()
        
//        audioPlayer.play("http://www.abstractpath.com/files/audiosamples/sample.mp3")
        
        
        let mapURL = NSURL(string:"http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer")
        let mapLayer = AGSTiledMapServiceLayer.tiledMapServiceLayerWithURL(mapURL) as! AGSTiledMapServiceLayer
        mapView.addMapLayer(mapLayer, withName: baseMapTiledLayerName)
        mapView.layerDelegate = self
        mapView.frame = view.frame
        view.addSubview(mapView)
        
        
    }
}

extension SongViewController: AGSMapViewLayerDelegate {
 
    func mapViewDidLoad(mapView: AGSMapView!) {
        mapView.locationDisplay.startDataSource()
    }
    
}
