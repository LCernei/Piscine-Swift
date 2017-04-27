let card1 = Card(color: .Spade, value: .King)
let card2 = Card(color: .Spade, value: .King)

print(card1.description)
print(card2)
print(card1.isEqual(card2))

let card3 = Card(color: .Club, value: .Ace)
let card4 = Card(color: .Heart, value: .Ten)

print(card3)
print(card4.description)
print(card3 == card4)
