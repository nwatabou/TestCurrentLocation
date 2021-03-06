//
//  ViewController.swift
//  TestCurrentLocation
//
//  Created by nancy on 2020/02/02.
//  Copyright © 2020 nancy. All rights reserved.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils

class ViewController: UIViewController {

  // デフォルトの位置情報（仮で東京駅付近にしています）
    let defaultPositionLat = 35.681223
    let defaultPositionLng = 139.767059
    private var mapView: GMSMapView!
    /// Map 上に表示するマーカーを管理するためのプロパティ
    private var clusterManager: GMUClusterManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        // GoogleMapの初期位置
        let camera = GMSCameraPosition.camera(withLatitude: defaultPositionLat, longitude: defaultPositionLng, zoom: 17.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView

        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)

        // マーカーをランダムに生成して Map 上に表示
        generateClusterItems()
    }

    private func generateClusterItems() {
        let extent = 0.01
        for _ in 1...100 {
            let lat = defaultPositionLat + extent * randomScale()
            let lng = defaultPositionLng + extent * randomScale()
            let item = POIItem(position: CLLocationCoordinate2DMake(lat, lng))
            clusterManager.add(item)
        }
        // Map にマーカーを描画
        clusterManager.cluster()
    }

    /// ランダムな位置にマーカーを表示するための乱数を生成
    private func randomScale() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
    }
}

/*
class ViewController: UIViewController {

    var mapView = GMSMapView()
    var locationManager = CLLocationManager()
    let baseUrl = "https://maps.googleapis.com/maps/api/directions/json"
    let ginzaSixLocation = "35.669798,139.7639302"

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
        locationManager.delegate = self
        // ユーザにアプリ使用中のみ位置情報取得の許可を求めるダイアログを表示
        locationManager.requestWhenInUseAuthorization()
        // 常に取得したい場合はこちら↓
        // locationManager.requestAlwaysAuthorization()
    }
    
    private func getDirection(destination: String, start startLocation: String, completion: @escaping (Direction) -> Void) {
        
        guard var components = URLComponents(string: baseUrl) else { return }
        
        components.queryItems = [
            URLQueryItem(name: "key", value: GOOGLE_API_KEY),
            URLQueryItem(name: "mode", value: "walking"),
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
    
    private func showRoute(_ direction: Direction) {
        guard let route = direction.routes.first, let leg = route.legs.first else { return }
        let path = GMSMutablePath()
        for step in leg.steps {
            path.add(CLLocationCoordinate2D(latitude: step.startLocation.lat,
                                            longitude: step.startLocation.lng))
            path.add(CLLocationCoordinate2D(latitude: step.endLocation.lat,
                                            longitude: step.endLocation.lng))
        }
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 4.0
        polyline.map = mapView
        updateCameraZoom(startLat: leg.startLocation.lat,
                         startLng: leg.startLocation.lng,
                         endLat: leg.endLocation.lat,
                         endLng: leg.endLocation.lng)
    }
    
    private func updateCameraZoom(startLat: Double, startLng: Double, endLat: Double, endLng: Double) {
        let startCoordinate = CLLocationCoordinate2D(latitude: startLat, longitude: startLng)
        let endCoordinate = CLLocationCoordinate2D(latitude: endLat, longitude: endLng)
        let bounds = GMSCoordinateBounds(coordinate: startCoordinate, coordinate: endCoordinate)
        let cameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 16.0)
        mapView.moveCamera(cameraUpdate)
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let startLocation = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        getDirection(destination: ginzaSixLocation,
                     start: startLocation,
                     completion: { [weak self] direction in
                        DispatchQueue.main.async {
                            self?.showRoute(direction)
                        }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
*/
