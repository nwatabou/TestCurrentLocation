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
    private let baseUrl = "https://maps.googleapis.com/maps/api/directions/json"

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
        
        getDirection(for: "35.6910964,139.7655842", start: "35.681223,139.767059", completion: { direction in
            print(direction)
        })
    }
    
    private func requestLoacion() {
        // ユーザにアプリ使用中のみ位置情報取得の許可を求めるダイアログを表示
        locationManager.requestWhenInUseAuthorization()
        // 常に取得したい場合はこちら↓
        // locationManager.requestAlwaysAuthorization()
    }
    
    private func getDirection(for destination: String, start startLocation: String, completion: @escaping (Direction) -> Void) {
        
        guard var components = URLComponents(string: baseUrl) else { return }
        
        components.queryItems = [
            URLQueryItem(name: "key", value: GOOGLE_API_KEY),
            URLQueryItem(name: "origin", value: startLocation),
            URLQueryItem(name: "destination", value: destination)
        ]
        
        guard let url = components.url else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decorder = JSONDecoder()
                do {
                    let direction = try decorder.decode(Direction.self, from: data)
                    completion(direction)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(error ?? "Error")
            }
        }
        task.resume()
    }
}
