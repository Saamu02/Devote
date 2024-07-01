//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Ussama Irfan on 01/07/2024.
//

import SwiftUI

struct BackgroundImageView: View {
     
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundImageView()
}
