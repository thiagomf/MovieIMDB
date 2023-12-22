//
//  CarouselUIView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 21/12/23.
//


//não funciona adequadamente
import SwiftUI

struct CarouselUIView: View {
    
    let cards = [Card(),Card(),Card(),Card(),Card(),Card()]
    
    @State private var screenWidth: CGFloat = 0
    @State private var cardHeight: CGFloat = 0
    let widthScale = 0.75
    let cardAspectRatio = 1.5
    @State var activeCardIndex = 0
    @State var dragOffSet: CGFloat = 0
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                ForEach(cards.indices, id: \.self) { index in
                    VStack {
                        Text("Hello")
                    }
                    .frame(width: screenWidth * widthScale,
                           height: cardHeight)
                    .background(cards[index].colors[index % cards.count])
                    .overlay(Color.white.opacity(1 - cardScale(for: index, proportion: 0.4)))
                    .cornerRadius(20)
                    .offset(x: cardOffSet(for: index))
                    .scaleEffect(x: cardScale(for: index), y: cardScale(for: index))
                    .zIndex(-Double(index))
                    .gesture(DragGesture().onChanged { value in
                        self.dragOffSet = value.translation.width
                    }.onEnded { value in
                        let threshold = screenWidth * 0.2
                        withAnimation {
                            if value.translation.width < -threshold {
                                activeCardIndex = min(activeCardIndex + 1, cards.count - 1)
                            } else 
                            if value.translation.width > threshold {
                                activeCardIndex = max(activeCardIndex - 1, 0)
                            }
                        }
                        
                        withAnimation{
                            dragOffSet = 0
                        }
                    })
                }
            }.onAppear() {
                screenWidth = reader.size.width
                cardHeight = screenWidth * widthScale * cardAspectRatio
            }
            .offset(x: 16, y: 30)
        }
    }
    
    func cardScale(for index: Int, proportion: CGFloat = 0.2) -> CGFloat {
        let adjustedIndex = index - activeCardIndex
        if index >= activeCardIndex {
            let progress = min(abs(dragOffSet)/(screenWidth/2), 1)
            return 1 - proportion * CGFloat(adjustedIndex) + (dragOffSet < 0 ? proportion * progress : -proportion * progress)
        }
        return 1
    }
    
    func cardOffSet(for index: Int) -> CGFloat {
        let adjustedIndex = index - activeCardIndex
        let cardSpacing: CGFloat = 60 / cardScale(for: index)
        let initialOffset = cardSpacing * CGFloat(adjustedIndex)
        let progress = min(abs(dragOffSet)/(screenWidth/2), 1)
        let maxCardMovement = cardSpacing
        if adjustedIndex < 0 {
            if dragOffSet > 0 && index == activeCardIndex - 1 {
                let distanteToMove = (initialOffset + screenWidth) * progress
                return -screenWidth + distanteToMove
            } else {
                return -screenWidth
            }
        } else if index > activeCardIndex {
            let distanceToMove = progress * maxCardMovement
            return initialOffset - (dragOffSet < 0 ? distanceToMove : -distanceToMove)
        } else {
            if dragOffSet < 0 {
                return dragOffSet
            } else {
                let distanceToMove = maxCardMovement * progress
                return initialOffset - (dragOffSet < 0 ? distanceToMove : -distanceToMove)
            }
        }
    }
}

#Preview {
    CarouselUIView()
}

struct Card {
    let id = UUID()
    let colors: [Color] = [.red, .blue, .yellow, .orange, .green, .purple, .cyan, .mint, .pink]
}
