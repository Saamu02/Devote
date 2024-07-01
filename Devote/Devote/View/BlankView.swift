//
//  BlankView.swift
//  Devote
//
//  Created by Ussama Irfan on 01/07/2024.
//

import SwiftUI

struct BlankView: View {
    
    var body: some View {

        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
        .opacity(0.5)
    }
}

#Preview {
    BlankView()
}
