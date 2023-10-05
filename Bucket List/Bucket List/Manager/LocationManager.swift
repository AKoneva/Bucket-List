//
//  LocationManager.swift
//  Bucket List
//
//  Created by Анна Перехрест  on 2023/10/04.
//
import MapKit
import _MapKit_SwiftUI

// region isnt changing when Im moving on map
final class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 49.28357, longitude: 31.15112),
        span: .init(latitudeDelta: 25, longitudeDelta: 25)
    )
//    @Published var camera: MapCameraPosition = .automatic
}
//    override init() {
//        super.init()
//        
//        camera = .region(region)
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.setup()
//    }
//    
//    func setup() {
//        switch locationManager.authorizationStatus {
//        //If we are authorized then we request location just once, to center the map
//        case .authorizedWhenInUse:
//            locationManager.requestLocation()
//          
//        case .notDetermined:
//            locationManager.startUpdatingLocation()
//            locationManager.requestWhenInUseAuthorization()
//        default:
//            break
//        }
//    }
//}

//extension LocationManager: CLLocationManagerDelegate {
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
//        locationManager.requestLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Something went wrong: \(error)")
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        locationManager.stopUpdatingLocation()
////        locations.last.map {
////            region = MKCoordinateRegion(
////                center: $0.coordinate,
////                span: .init(latitudeDelta: 25, longitudeDelta: 25)
////            )
////        }
//    }
//}
