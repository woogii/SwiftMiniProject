//
//  Constants.swift
//  Colour Memory
//
//  Created by Hyun on 2016. 4. 30..
//  Copyright © 2016년 siwook. All rights reserved.
//

import Foundation


// MARK : Constants

struct Constants {
    
    // MARK : CoreData
    
    static let EntityName           = "ScoreList"
    static let KeyName              = "name"
    static let KeyScore             = "score"
    static let KeyRank              = "rank"
    static let KeyDate              = "recordTime"
    static let CoreDataFileName     = "ScoreList.sqlite"
    static let ModelName            = "Model"
    static let ModelExtension       = "momd"
    
    // MARK : AlertController
    
    static let AlertTitle           = "Mission Completed!"
    static let AlertMessage         = "Enter your name"
    static let AlertPlaceholder     = "Name"
    static let ActionOk             = "Ok"
    static let ActionCancel         = "Cancel"
    
    // MARK : TableView
    
    static let HeaderCellIdentifier = "sectionHeader"
    static let CellIdentifier       = "scoreCell"
    static let HeaderFirstColumn    = "RANK"
    static let HeaderSecondColumn   = "NAME"
    static let HeaderThirdColumn    = "SCORE"
    static let NumOfHeader          = 1
    static let layoutContraintValue = 109

    // MARK : Segue
    struct Segue {
        static let ShowScoreVCWithExtraInformation = "showScoreVC"
        static let ShowScoreVCWithTableOnly   = "showScoreTable"
    }

    // MARK : Score Label
    
    static let InitScoreLabelText   = "Score : 0"
    static let ScoreLabelText       = "Score : "
    static let ResultScoreText      = "Your Current Score : "
    static let ResultRankText       = "Your Rank  : "
    static let ResultNoRankText     = "Your Rank  : No Record Found"
    
    // MARK : Image Names
    
    static let ColourSetBlue        = "img_blue"
    static let ColourSetBrown       = "img_brown"
    static let ColourSetDarkGreen   = "img_darkGreen"
    static let ColourSetGreen       = "img_green"
    static let ColourSetLightBlue   = "img_lightBlue"
    static let ColourSetOlive       = "img_olive"
    static let ColourSetPurple      = "img_purple"
    static let ColourSetRed         = "img_red"
    static let BackGroundImageName  = "img_card_background"

    // MARK : Orientation 
    
    static let KeyOrientation       = "orientation"
    
    // MARK : Point
    
    static let MatchingPoint        = 5
    static let PenaltyPoint         = -1
    
    // MARK : Error
    
    static let CreateOrLoadError    = "There was an error creating or loading the application's saved data."
    static let FailToInitSavedData  = "Failed to initialize the application's saved data"
    static let ErrorDomain          = "persistent coordinator create"
    static let ErrorLogPrefix       = "Unresolved error"
    
    // MARK : Delay
    
    static let DelayIfMathced       = 0.7
    static let DelayIfNotMathced    = 0.7
    
    // MARK : TalbeView header
    static let HighScoreTableViewHeaderNib = "HighScoreTableViewHeader"
    static let HighScoreTableViewHeaderIdentifier = "highScoreTableViewHeader"
    
    static let numOfFlippedCards    = 2
}
