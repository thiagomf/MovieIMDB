//
//  DiscoveringUIView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 22/12/23.
//

import SwiftUI

struct DiscoveringUIView: View {
   
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                CarouselUIView()
                
                GenreUIView()
                
                DiscoveryUIView()
                
            }.navigationTitle("Wanna see")
            
        }
        
    }
}

#Preview {
    DiscoveringUIView()
}
