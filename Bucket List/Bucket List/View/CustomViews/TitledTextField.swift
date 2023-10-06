//
//  TitledTextField.swift
//  Bucket List
//
//  Created by Анна Перехрест  on 2023/10/05.
//

import SwiftUI

struct TitledTextField: View {
    let placeholder: String
    
    @Binding var text: String
    
    let isTextField: Bool

    
    var body: some View {
        ZStack(alignment: .leading) {
            if isTextField {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondary, lineWidth: 0.3)
                    )
                if !text.isEmpty {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        Text(placeholder)
                            .padding(.horizontal)
                            .background(Color(.systemBackground))
                            .font(.footnote)
                            .bold()
                            .foregroundStyle(.secondary)
                            .offset(x: 20, y: -25)
                            .transition(.slide)
                    }
                }
            } else {
                TextEditor(text: $text)
                    .padding()
                    .frame(height: 100)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondary, lineWidth: 0.3)
                    )
                if !text.isEmpty {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        Text(placeholder)
                            .padding(.horizontal)
                            .background(Color(.systemBackground))
                            .font(.footnote)
                            .bold()
                            .foregroundStyle(.secondary)
                            .offset(x: 20, y: -50)
                            .transition(.slide)
                    }
                }
            }

        }
        .padding()
    }
}

#Preview {
    TitledTextField(placeholder: "placeholder", text: .constant("hgcvcvcvcvcvcvcvcvcvjvkcvhbjfhgsjdhgfjshdgfjsdgfjshdgfsjhgfjshdkfksjdfhksdhfkf"), isTextField: false)
}
