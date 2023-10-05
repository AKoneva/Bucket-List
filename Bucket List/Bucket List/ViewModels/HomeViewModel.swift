//
//  ContentView-ViewModel.swift
//  Bucket List
//
//  Created by Анна Перехрест  on 2023/10/04.
//

import Foundation
import LocalAuthentication

extension HomeView {
    @MainActor class ViewModel: ObservableObject {
        @Published var isUnlocked = false
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        // error
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}
