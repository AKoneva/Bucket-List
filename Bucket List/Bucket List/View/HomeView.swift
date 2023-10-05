//
//  ContentView.swift
//  Bucket List
//
//  Created by Анна Перехрест  on 2023/10/03.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isUnlocked {
                MapView()
            } else {
                Button("Unlock Places") {
                    viewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    HomeView()
}
