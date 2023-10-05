//
//  EditView.swift
//  Bucket List
//
//  Created by Анна Перехрест  on 2023/10/04.
//

import SwiftUI
import MapKit

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ViewModel
    @State private var lookAroundScene: MKLookAroundScene?
    
    var onSave: (Location) -> Void
    
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TitledTextField(placeholder: "Name", text: $viewModel.name, isTextField: true)
                TitledTextField(placeholder: "Description", text: $viewModel.description, isTextField: false)
                
                if let scene = lookAroundScene {
                    LookAroundPreview(initialScene: scene)
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                } else {
                    ContentUnavailableView("No preview avaliable", systemImage: "eye.slash")
                }
                
                HStack {
                    Text("Nearby…")
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    
                    Spacer()
                }
                
                switch viewModel.loadingState {
                case .loaded:
                    List(viewModel.pages, id: \.pageid) { page in
                        VStack(alignment: .leading) {
                            Text(page.title)
                                .font(.title3)
                                .bold()
                            Text(page.description)
                                .italic()
                        }
                    }
                    .listStyle(.plain)
                case .loading:
                    Text("Loading…")
                case .failed:
                    Text("Please try again later.")
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
                
                let request = MKLookAroundSceneRequest(coordinate: viewModel.location.coordinate)
                lookAroundScene = try? await request.scene
            }
        }
    }
}


#Preview {
    EditView(location: Location.example) { newLocation in }
}
