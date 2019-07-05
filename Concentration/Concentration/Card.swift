//
//  Card.swift
//  Concentration
//
//  Created by Raul Marchis on 02/07/2019.
//  Copyright © 2019 Raul Marchis. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier = 0
    // NU PUNEM EMOJI PENTRU CA MODELUL E
    // INDEPENDENT FATA DE VIEW

    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
