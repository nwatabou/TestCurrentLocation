//
//  ViewController.swift
//  TestCurrentLocation
//
//  Created by nancy on 2020/02/02.
//  Copyright © 2020 nancy. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    var mapView = GMSMapView()
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        requestLoacion()
    }

    private func setupMap() {
        // GoogleMapの初期位置(仮で東京駅付近に設定)
        let camera = GMSCameraPosition.camera(withLatitude: 35.6812226, longitude: 139.7670594, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
    }
    
    private func requestLoacion() {
        // ユーザにアプリ使用中のみ位置情報取得の許可を求めるダイアログを表示
        locationManager.requestWhenInUseAuthorization()
        // 常に取得したい場合はこちら↓
        // locationManager.requestAlwaysAuthorization()
    }
}
