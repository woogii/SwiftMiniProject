//
//  Pack.swift
//  Colour Memory
//
//  Created by Hyun on 2016. 4. 23..
//  Copyright © 2016년 siwook. All rights reserved.
//

import Foundation

// MARK : - Pack : NSObject 

class Pack : NSObject {
    
    // MARK : Property
    
    var cards = [Card]()
    
    // MARK : Add Card
    
    func addCard(_ newCard:Card) {
        cards.append(newCard)
    }
    
    // MARK : Pick Random Card
    
    /// Return Card object with random index from Card Array.
    /// After return, the card object is removed from the array
    /// - Returns: Card object
    
    func pickRandomCard()->Card?{
        
        var randomCard:Card?
        
        if cards.count > 0  {
            
            // Pick random card and delete it from the card pack
            let index = Int(arc4random_uniform(UInt32(cards.count)))
            randomCard = cards[index]
            cards.remove(at: index)
        }
        
        return randomCard
    }
}
