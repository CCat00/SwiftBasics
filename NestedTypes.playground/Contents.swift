/**
 嵌套类型 (Nested Types)
 */

struct BlackjackCard {
    // 嵌套的 Suit 枚举
    enum Suit: Character {
        case Spades = "♠️", Hearts = "💗", Diamonds = "♦️", Clubs = "♣️"
    }
    
    // 嵌套的 Rank 枚举
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, sencond: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values.init(first: 1, sencond: 11)
            case .Jack, .Queen, .King:
                return Values.init(first: 10, sencond: nil)
            default:
                return Values.init(first: self.rawValue, sencond: nil)
            }
        }
    }
    
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += "value is \(rank.values.first)"
        if let second = rank.values.sencond {
            output += " or \(second)"
        }
        return output
    }

}

let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print(theAceOfSpades.description)


let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue;
print(heartsSymbol)

