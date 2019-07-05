//
//  Concentration.swift
//  Concentration
//
//  Created by Raul Marchis on 02/07/2019.
//  Copyright © 2019 Raul Marchis. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]() // sau = Array<Card>()
    var evidenceAppearanceOfCards = [Int]()
    var flipCount = 0
    var score = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    lazy var numberOfPairOfCardsVar: Int = 0
    var totalNumberOfMatches = 0
    
    var firstCardFlipped = true
    var startOfGameTime = Date()
    
    func chooseCard(at index: Int) {
        flipCount += 1
        if firstCardFlipped == true {
            startOfGameTime = Date()
            firstCardFlipped = false;
        }
        
        if !cards[index].isMatched {
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                evidenceAppearanceOfCards[index] += 1
                evidenceAppearanceOfCards[matchIndex] += 1
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    totalNumberOfMatches += 1
                    if totalNumberOfMatches == numberOfPairOfCardsVar {
                        let endOfGameTime = Date()
                        if score > -10, endOfGameTime.timeIntervalSince(startOfGameTime) < 50 {
                            print("Received a +10 bonus score for having a score greater than 10 in less than 30 seconds, congratulations!")
                            score += 10
                        }
                       
                    }
                    score += 2
                    evidenceAppearanceOfCards[index] = 0
                    evidenceAppearanceOfCards[matchIndex] = 0
                } else {
                    if evidenceAppearanceOfCards[index] >= 2 {
                        score -= 1
                    }
                    if evidenceAppearanceOfCards[matchIndex] >= 2 {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
       
    }
    
    func shuffleTheCards() {
        cards.removeAll()
        
        var temporaryIndices = [Int]()
        var temporaryCards = [Card]()
        
        for _ in 1...numberOfPairOfCardsVar {
            let card = Card()
            temporaryCards += [card, card]
        }
        
        for _ in 1...numberOfPairOfCardsVar * 2 {
            temporaryIndices.append(0)
        }
        
        for _ in 1...numberOfPairOfCardsVar * 2 {
            var temporaryIndex = Int(arc4random_uniform(UInt32(numberOfPairOfCardsVar * 2)))
            while(temporaryIndices[temporaryIndex] == 1) {
                temporaryIndex = Int(arc4random_uniform(UInt32(numberOfPairOfCardsVar * 2)))
            }
            
            temporaryIndices[temporaryIndex] = 1;
            cards.append(temporaryCards[temporaryIndex])
        }
    }
    
    func restartScore() {
        score = 0
        evidenceAppearanceOfCards.removeAll()
        for _ in 1...numberOfPairOfCardsVar * 2 {
            evidenceAppearanceOfCards.append(0)
        }
    }
    
    init(numberOfPairOfCards: Int) {
        numberOfPairOfCardsVar = numberOfPairOfCards
        
        restartScore()
        shuffleTheCards()
    }
}


