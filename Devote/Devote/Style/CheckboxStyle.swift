//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Ussama Irfan on 01/07/2024.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
        
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            
            configuration.label
        } //: HStack
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Toggle("Placeholder Label", isOn: .constant(true))
        .toggleStyle(CheckboxStyle())
        .padding()
}
 
