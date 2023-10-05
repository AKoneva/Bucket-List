//
//  EditView.swift
//  Bucket List
//
//  Created by Анна Перехрест  on 2023/10/04.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    @StateObject private var viewModel: ViewModel
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TitledTextField(placeholder: "Name", text: $viewModel.name, isTextField: true)
                TitledTextField(placeholder: "Description", text: $viewModel.description, isTextField: false)
                
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
            }
        }
    }
}


#Preview {
    EditView(location: Location.example) { newLocation in }
}
