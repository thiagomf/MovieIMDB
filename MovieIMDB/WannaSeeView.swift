//
//  WannaSeeView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 05/12/23.
//

import SwiftUI

struct WannaSeeView: View {
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Future Favorites movies")
            }.navigationTitle("No title found")
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    WannaSeeView()
}
