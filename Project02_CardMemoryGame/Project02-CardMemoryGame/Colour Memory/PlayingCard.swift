//
//  PlayingCard.swift
//  Colour Memory
//
//  Created by Hyun on 2016. 4. 23..
//  Copyright © 2016년 siwook. All rights reserved.
//

import Foundation

// MARK : - PlayingCard : Card 

class PlayingCard : Card {
    
    // MARK : Property
    
    static let colourSet = [ Constants.ColourSetBlue,
                             Constants.ColourSetBrown,
                             Constants.ColourSetDarkGreen,
                             Constants.ColourSetGreen,
                             Constants.ColourSetLightBlue,
                             Constants.ColourSetOlive,
                             Constants.ColourSetPurple,
                             Constants.ColourSetRed
    ]
    
    // MARK : Initialization
    
    override init() {
        super.init()
    }
    
    // MARK : Matching Cards
    
    /// Initialize PlayingCard object with given colour description
    /// - Parameter colourDesc : Colour Description
    /// - Returns: An initialized object
    
    convenience init(colourDesc:String) {

        self.init()
        
        // Set colourDesc property value
        if(PlayingCard.colourSet.contains(colourDesc)) {
            self.colourDesc = colourDesc
        }
    }
   
    
    // MARK : Matching Cards

    /// Compare card objects based on the colour description
    /// If matched, matching score will be returned, otherwise zero score will be returned
    /// - Parameter otherCards: Card object array
    /// - Returns: score
    
    override func match(_ otherCards:[Card])-> Int{
        var score = 0
        
        // Compare the card with another card
        if(otherCards.count == 1) {
            
            guard let otherCard = otherCards.first else {
                return score
            }
            
            if colourDesc == otherCard.colourDesc {
                score = score + Constants.MatchingPoint
            }
        }
        
        return score
    }


}
