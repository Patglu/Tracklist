import SwiftUI

struct WaveCollapseView: View {
    @StateObject var viewModel = CardsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.cardGroups) { group in
                    if group.cards.count > 1 {
                        // This is a 2x2 grid group
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(group.cards) { card in
                                Rectangle()
                                    .frame(width: card.size.dimensions.width, height: card.size.dimensions.height)
                                    .foregroundColor(.green)
                                    .padding(4)
                            }
                        }
                    } else if let card = group.cards.first {
                        // This is a single card
                        Rectangle()
                            .frame(width: card.dimensions.width, height: card.dimensions.height)
                            .foregroundColor(.blue)
                            .padding(4)
                    }
                }
            }
        }
        .onAppear {
            viewModel.generateCardGroups(count: 20)
        }
    }
}

#Preview {
    WaveCollapseView()
}

enum CardLayout {
    case single, double
}



struct Card: Identifiable {
    let id = UUID()
    let size: CardSize
    var layout: CardLayout = .single // Default to single
    
    // New: Determine if this card is part of a 2x2 grid
    var isPartOfGrid: Bool = false
    var dimensions: CGSize {
        switch layout {
        case .single:
            return size.dimensions
        case .double:
            return CGSize(width: size.dimensions.width * 2 + 8, height: size.dimensions.height) // +8 for padding
        }
    }
}

// Represents a group of cards, which could be a single card or a 2x2 grid
struct CardGroup: Identifiable {
    let id = UUID()
    var cards: [Card]
}

// Define the card sizes
enum CardSize: CaseIterable {
    case small, medium, large
    
    var dimensions: CGSize {
        switch self {
        case .small: return CGSize(width: 100, height: 150)
        case .medium: return CGSize(width: 150, height: 225)
        case .large: return CGSize(width: 200, height: 300)
        }
    }
}


class CardsViewModel: ObservableObject {
    @Published var cardGroups: [CardGroup] = []
    
    func generateCardGroups(count: Int) {
        cardGroups = []
        var i = 0
        while i < count {
            // Randomly decide to create a single card or a 2x2 grid
            if Bool.random(), i <= count - 4 { // Ensure there's room for a 2x2 grid
                var gridCards = [Card]()
                for _ in 0..<4 { // Generate 4 cards for the grid
                    let size = CardSize.small // Assuming grid cards are of small size for simplicity
                    let card = Card(size: size, isPartOfGrid: true)
                    gridCards.append(card)
                }
                let cardGroup = CardGroup(cards: gridCards)
                cardGroups.append(cardGroup)
                i += 4
            } else {
                let size = CardSize.allCases.randomElement()!
                let card = Card(size: size)
                let cardGroup = CardGroup(cards: [card])
                cardGroups.append(cardGroup)
                i += 1
            }
        }
    }
}
