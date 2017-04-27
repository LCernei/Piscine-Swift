import Foundation

class Card: NSObject {
	var color: Color
	var value: Value

	init (color: Color, value: Value) {
		self.color = color
		self.value = value
	}

	override var description: String {
		get {
			let string = "(\(self.value), \(self.color))"
				return string
		}
	}

	static func ==(card1: Card, card2: Card) -> Bool {
		if ((card1.color == card2.color) && (card1.value == card2.value)) {
			return true
		}
		return false
	}

	override func isEqual(_ object: Any?) -> Bool {
		if object is Card {
			if object as! Card == self {
				return true
			}
		}
		return false
	}
}
