//
//  MapViewModel.swift
//  Bucket List
//
//  Created by Анна Перехрест  on 2023/10/04.
//

import Foundation
import MapKit
import _MapKit_SwiftUI

extension MapView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var cameraPosition: MapCameraPosition = .userLocation(followsHeading: false, fallback: .automatic)
      
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation(coordinates: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinates.latitude, longitude: coordinates.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
    }
}
