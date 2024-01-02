//
//  GenreUIView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 22/12/23.
//

import SwiftUI

struct GenreUIView: View {
    var body: some View {
        
        Text("Hello")
//        ScrollView {
//            HStack {
//                ForEach() { item in
//                    BoxView()
//                }
//            }
//        }.padding(20)
    }
}

struct BoxView: View {
    var body: some View {
        VStack {
            Image("")
                .resizable()
                .cornerRadius(12)
                .frame(width: 80, height: 80)
            
            Text("Genero")
                .font(.subheadline)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    GenreUIView()
}
