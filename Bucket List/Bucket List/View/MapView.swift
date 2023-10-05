//
//  MapView.swift
//  Bucket List
//
//  Created by Анна Перехрест  on 2023/10/04.
//
import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = ViewModel()
    @State var cameraCentreCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
   
    
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
            .ignoresSafeArea()
            .onMapCameraChange { mapCameraUpdateContext in
                cameraCentreCoordinate = mapCameraUpdateContext.camera.centerCoordinate
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
                Text("Locate blue circle where you want create annotation and press plus button. \nIf you want edit, press on annotation.")
                    .font(.footnote)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .padding()
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        viewModel.addLocation(coordinates: cameraCentreCoordinate)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
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
