//
//  SongViewController.swift
//  HackerNews
//
//  Created by Alex Choi on 5/2/15.
//  Copyright (c) 2015 Alex Choi. All rights reserved.
//
import StreamingKit
import SnapKit

enum MapLayerType: Int {
    case Ocean, Topo, Sat, NatGeo, LightGray
    static var allValues = [Ocean, Topo, Sat, NatGeo, LightGray]
    
    var URL: NSURL {
        let oceanMapURL = NSURL(string:"http://services.arcgisonline.com/ArcGIS/rest/services/Ocean_Basemap/MapServer")!
        let topographicMapURL = NSURL(string:"http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer")!
        let satelliteMapURL = NSURL(string:"http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer")!
        let natGeoMapURL = NSURL(string: "http://services.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer")!
        let lightGrayBaseMapURL = NSURL(string:"http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer")!
        switch self {
        case .Ocean:
            return oceanMapURL
        case .Topo:
            return topographicMapURL
        case .Sat:
            return satelliteMapURL
        case .NatGeo:
            return natGeoMapURL
        case .LightGray:
            return lightGrayBaseMapURL
        }
    }
    
    var mapLayer: AGSTiledMapServiceLayer {
        return AGSTiledMapServiceLayer.tiledMapServiceLayerWithURL(URL) as! AGSTiledMapServiceLayer
    }
    
    var name: String {
        switch self {
        case .Ocean:
            return "ocean"
        case .Topo:
            return "topo"
        case .Sat:
            return "sat"
        case .NatGeo:
            return "natgeo"
        case .LightGray:
            return "lightgray"
        }
    }
    
}

class ListenViewController: UIViewController {
    
    let segmentedControl = UISegmentedControl(items: MapLayerType.allValues.map { $0.name })
    let audioPlayer = STKAudioPlayer()
    var mapLayerType = MapLayerType.Topo {
        didSet {
            mapView.removeMapLayerWithName(oldValue.name)
            mapView.addMapLayer(mapLayerType.mapLayer)
        }
    }
    
    let mapView = AGSMapView()
    let baseMapTiledLayerName = "baseMapTiledLayerName"
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        title = "LISTEN"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        audioPlayer.play("http://www.abstractpath.com/files/audiosamples/sample.mp3")
        view.backgroundColor = UIColor.lightCreamColor()
        
        segmentedControl.tintColor = UIColor.purpleColor()
        segmentedControl.addTarget(self, action: "segmentedControlDidChange:", forControlEvents: .ValueChanged);
        view.addSubview(segmentedControl)
        segmentedControl.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(40)
            make.top.equalTo(view)
        }
        
        mapLayerType = .Topo
        mapView.layerDelegate = self
        mapView.touchDelegate = self
        view.addSubview(mapView)
        mapView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(view)
            make.height.equalTo(view.bounds.width)
            make.center.equalTo(view)
        }
        
    }
    
    func segmentedControlDidChange(sender: UISegmentedControl) {
        mapLayerType = MapLayerType(rawValue: sender.selectedSegmentIndex)!
    }
    
}

extension ListenViewController: AGSMapViewLayerDelegate, AGSMapViewTouchDelegate {
    func mapViewDidLoad(mapView: AGSMapView!) {
        mapView.locationDisplay.startDataSource()
    }
}
