//
//  ViewController.swift
//  Concentration
//
//  Created by Raul Marchis on 02/07/2019.
//  Copyright © 2019 Raul Marchis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
    lazy var index = Int(arc4random_uniform(UInt32(totalNumberOfThemes)))

    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            //game.flipCount += 1
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scoreLabel.text = "Score: \(game.score)"
            updateViewFromModel(at: index)
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func resetGameButton(_ sender: UIButton) {
        for index in 0..<game.cards.count {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            game.indexOfOneAndOnlyFaceUpCard = nil
        }
        
            game.firstCardFlipped = true
            game.totalNumberOfMatches = 0
            game.flipCount = 0
            game.restartScore()
        
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scoreLabel.text = "Score: \(game.score)"
        
        
            index = Int(arc4random_uniform(UInt32(totalNumberOfThemes)))
            self.view.backgroundColor = backGroundSpecificToTheme[index]
            emojiChoices = themeChoices[index]!
           // for index in 0..<emojiChoices.count {
           //     print("\(emojiChoices[index])")
           // }
            for index in 0..<emoji.count {
                emoji[index] = nil
            }
            game.shuffleTheCards()
            updateViewFromModel(at: index)
    }
    
    
    func updateViewFromModel(at colorIndex: Int) {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            self.view.backgroundColor = backGroundSpecificToTheme[self.index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = backOfCardsSpecificToTheme[colorIndex]
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? backGroundSpecificToTheme[colorIndex] : backOfCardsSpecificToTheme[colorIndex]
            }
        }
    }
    
    let totalNumberOfThemes = 6
    
    var backGroundSpecificToTheme = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)]
    var backOfCardsSpecificToTheme = [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
    var halloweenTheme = ["🎃", "😈", "💊", "☠️", "🧟‍♂️", "👻", "🧛‍♂️", "🧞‍♀️"]
    var animalsTheme = ["🐶", "🐥", "🐍", "🦂", "🦈", "🐙", "🐿", "🐲"]
    var sportsTheme = ["⚽️", "🏀", "🎾", "🎱", "🏹", "🏄‍♀️", "🚴‍♂️", "🏓"]
    var facesTheme = ["😀", "😎", "😡", "🤗", "☺️", "🤠", "😱", "😭"]
    var heartsTheme = ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "💕"]
    var foodsTheme = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇"]
    
    lazy var themeChoices : [Int: [String]] = {
        
        var dictionary = [Int: [String]]()
        dictionary[0] = halloweenTheme
        dictionary[1] = animalsTheme
        dictionary[2] = sportsTheme
        dictionary[3] = facesTheme
        dictionary[4] = heartsTheme
        dictionary[5] = foodsTheme
        
        return dictionary
    }()
    
    var emoji = Dictionary<Int, String>()
    lazy var emojiChoices = themeChoices[Int(arc4random_uniform(UInt32(totalNumberOfThemes)))]!
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
       return emoji[card.identifier] ?? "?"
    }
    
}


