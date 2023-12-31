//
//  MapView.swift
//  Bucket List
//
//  Created by Анна Перехрест  on 2023/10/04.
//
import SwiftUI
import MapKit

struct MapView: View {
    @Namespace private var mapScope
    
    @StateObject private var viewModel = ViewModel()
    
    @State var cameraCentreCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State var mapStyle: MapStyle = .hybrid(elevation: .realistic)
    
    
    var body: some View {
        ZStack {
            Map(position: $viewModel.cameraPosition) {
                UserAnnotation()
                ForEach(viewModel.locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 32, height: 32)
                            .background(.white)
                            .clipShape(Circle())
                            .onTapGesture {
                                viewModel.selectedPlace = location
                            }
                    }
                }
            }
            .mapScope(mapScope)
            .mapStyle(mapStyle)
            .onMapCameraChange { context in
                cameraCentreCoordinate = context.camera.centerCoordinate
            }
            .mapControls {
                MapUserLocationButton()
            }
            
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            Image(systemName: "plus")
                .foregroundColor(.blue)
                .opacity(0.4)
                .font(.title2)
                .frame(width: 32, height: 32)
            
            VStack {
                HStack {
                    Spacer()
                    MapCompass(scope: mapScope)
                        .padding(5)
                        .padding(.top, 50)
                }
                
                if viewModel.locations == [] {
                    Text("Locate blue circle where you want create annotation and press plus button. \nIf you want edit, press on annotation.")
                        .font(.footnote)
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .padding()
                }
                Spacer()
                
                HStack {
                    Spacer()
                    Menu("Map style") {
                        Button("Realistic map ") {
                            mapStyle = .hybrid(elevation: .realistic)
                        }
                        Button("Realistic flat map ") {
                            mapStyle = .hybrid(elevation: .flat)
                        }
                        Button("Standart map ") {
                            mapStyle = .standard(elevation: .automatic)
                        }
                    }
                    .padding()
                    .foregroundStyle(.primary)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    Button {
                        viewModel.addLocation(coordinates: cameraCentreCoordinate)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .foregroundStyle(.primary)
                    .background(.thinMaterial)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) {
                viewModel.update(location: $0)
            }
        }
    }
}

#Preview {
    MapView()
}
