import Foundation

class Deck: NSObject {
	static let allSpades : [Card] = Value.allValues.map{Card(color: Color.Spade, value: $0)}
	static let allDiamonds : [Card] = Value.allValues.map{Card(color: Color.Diamond, value: $0)}
	static let allHearts : [Card] = Value.allValues.map{Card(color: Color.Heart, value: $0)}
	static let allClubs : [Card] = Value.allValues.map{Card(color: Color.Club, value: $0)}
	static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs

	var cards: [Card] = allCards
	var discards: [Card] = []
	var outs: [Card] = []

	init(toMix: Bool) {
		if toMix {
			cards.mixArray()
		}
	}

	override var description: String {
		return "\(cards)"
	}

	func draw() -> Card? {
		if cards.count < 1 {
			return nil
		}
		outs.insert(cards.first!, at: 0)
		cards.removeFirst()
		return nil
	}

	func fold(current: Card) {
		var i = 0
		for card in outs {
			if (card == current) {
				outs.remove(at: i)
				discards.insert(current, at: 0)
				break
			}
			i += 1
		}
	}
}

extension Array {
	mutating func mixArray(){
		for i in startIndex ..< endIndex - 1 {
			let j = Int(arc4random_uniform(UInt32(count - i))) + i
				guard i != j else {
					continue
				}
			swap(&self[i], &self[j])
		}
	}
}
