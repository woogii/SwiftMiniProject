//
//  GameBoardViewController.swift
//  Colour Memory
//
//  Created by Hyun on 2016. 4. 23..
//  Copyright © 2016년 siwook. All rights reserved.
//

import UIKit
import CoreData

// MARK : - MemoryGameViewController : UIViewController

class GameBoardViewController: UIViewController {
    
    // MARK : Property
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreBtn: BorderedButton!
    
    var cardButtons:[UIButton]! {
        return [button1,button2,button3,button4,button5,button6,button7,button8,
                button9,button10,button11,button12,button13,button14,button15,button16]
    }
    var sharedContext : NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    weak var actionToEnable : UIAlertAction?
    var userName  = String()
    var userScore = Int()
    var rank      = 0
    var previousSelectedCardIndex:Int!
    var gameMatchManager = CardMatchingManager()
    var scoreDict        = [String:AnyObject]()
    var scoreList        = [ScoreList]()
    var selectedCards     = [Card]()
    var buttonIndices    = [Int]()
    
    // MARK : Fetch score list
    
    func fetchAllScores()->[ScoreList] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.EntityName)
        let sortDescriptorByScore = NSSortDescriptor(key: Constants.KeyScore, ascending: false)
        let sortDescriptorByDate  = NSSortDescriptor(key: Constants.KeyDate,  ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptorByScore, sortDescriptorByDate]
        
        do {
            return try sharedContext.fetch(fetchRequest) as! [ScoreList]
        } catch let error as NSError {
            print(error.description)
            return [ScoreList]()
        }
    }
    
    // MARK : View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreList = fetchAllScores()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resetGame()
    }
    
    // MARK : Reset Game
    
    func resetGame() {
        
        scoreLabel.text = Constants.InitScoreLabelText
        rank = 0
        gameMatchManager = CardMatchingManager(count: cardButtons.count, pack: PlayingPack())
        placeCardsFaceDown()
    }
    
    // MARK : Place cards face down
    
    func placeCardsFaceDown() {
        
        for card in cardButtons  {
            card.setBackgroundImage(UIImage(named:Constants.BackGroundImageName), for: UIControlState())
            card.alpha = 1.0
        }
    }
    
    // MARK : Set AutoRotate option
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    
    // MARK : Save Scores
    
    func saveHighScoreList() {
        
        scoreDict[Constants.KeyName]  = userName as AnyObject?
        scoreDict[Constants.KeyScore] = userScore as AnyObject?
        scoreDict[Constants.KeyDate]  = Date() as AnyObject?

        let newScore = ScoreList(dictionary: scoreDict, context: self.sharedContext)
        scoreList.append(newScore)
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    // MARK : Process(= Rank,Sort and save Result) game result
    
    func processGameResult() {
        
        // If there is scores saved
        if( scoreList.count > 0 ) {
            
            // If the current user's score is higher than the existing highest score
            if( gameMatchManager.getScore() >= Int(scoreList[0].score) ){
                
                saveHighScoreList()
                rank = 1
            } else {
                
                for i in 0..<scoreList.count {
                    
                    if scoreList[i].name == userName {
                        rank = i + 1
                        break
                    }
                }
            }
            
        } else {
            // First player will be ranked at the top spot
            rank = 1
            saveHighScoreList()
        }
        
        
        // Sort ScoreList after appending data
        scoreList.sort(by: {
            // If there are records with same score, then sort records by the 'date' property
            if $0.score as Int == $1.score as Int {
                return $0.recordTime.compare($1.recordTime as Date) == ComparisonResult.orderedDescending
            }
            return $0.score as Int > $1.score as Int
        })
        
        
    }
    
    // MARK : Button Action
    
    @IBAction func tapCardButton(_ sender: UIButton)
    {
        
        guard let selectedBtnIndex = cardButtons.index(of: sender) else {
            return
        }
        
        guard let card = gameMatchManager.cardAtIndex(selectedBtnIndex) else {
            return
        }
        
        if !selectedCards.contains(card) {      // check whether selecting the same card
            
            gameMatchManager.selectCardAtIndex(selectedBtnIndex)
            
            // if more than two cards are selected
            if countNumberOfFlippedCards() > 2 {
                
                // invalidate all information related to the selected card
                invalidateSelectedCardInformation(card: card)
                return
                
            } else {
                
                performUIUpdateWhenSelectDifferentCards()
            }
        } else {
            
            performUIUpdateWhenSelectSameCard()
            
        }
    }
    
    func performUIUpdateWhenSelectSameCard() {
        
        for i in 0..<selectedCards.count {
            
            // Set as not selected
            selectedCards[i].isSelected = false
            
            // Update Card background image as default image
            let imageName = getBackgroundImage(selectedCards[i])
            cardButtons[buttonIndices[i]].setBackgroundImage(UIImage(named:imageName), for: UIControlState())
            
            // Adjust game score
            gameMatchManager.adjustScoreWhenSelectedSameCard()
            
        }
        
        scoreLabel.text =  Constants.ScoreLabelText + String(self.gameMatchManager.getScore())
        
        // Initialize both arrays
        initializeSelectedCardAndButtonIndicesArray()
    }
    
    
    
    func invalidateSelectedCardInformation(card:Card) {
        
        card.isMatched = false
        card.isSelected = false
        selectedCards.removeLast()
        buttonIndices.removeLast()
    }
    
    func initializeSelectedCardAndButtonIndicesArray() {
        selectedCards = [Card]()
        buttonIndices = [Int]()
        
    }
    
    // MARK : UI Update
    
    func performUIUpdateWhenSelectDifferentCards() {
        
        let numberOfFlippedCards = countNumberOfFlippedCards()
        
        
        for cardButton in cardButtons {
            
            guard let index = cardButtons.index(of: cardButton) else {
                return
            }
            
            guard let card =  gameMatchManager.cardAtIndex(index) else {
                return
            }
            
            let imageName = self.getBackgroundImage(card)
            cardButton.setBackgroundImage(UIImage(named:imageName), for: UIControlState())
            
            // Hidden card after posing one second
            // Have to use alpha property since stackview was adopted
            if card.isMatched {
                
                // Creates a dispatch_time_t relative to the default clock or modifies an existing dispatch_time_t.
                let time = DispatchTime.now() + Double(Int64(Constants.DelayIfMathced * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                
                // Enqueue a block for execution at the specified time
                DispatchQueue.main.asyncAfter(deadline: time) {
                    cardButton.alpha = 0.0
                }
            } else {
                cardButton.alpha = 1.0
            }
            
            
            scoreLabel.text =  Constants.ScoreLabelText + String(self.gameMatchManager.getScore())
        }
        
        
        // If there are more than two cards selected
        if numberOfFlippedCards >= Constants.numOfFlippedCards {
            placeFippedCardsFaceDown()
        }
        
        
        // All cards are matched, show alert message to ask user to input his/her name
        if gameMatchManager.numOfMatchedCard() == cardButtons.count {
            showAlert()
        }
    }
    
    // MARK : Calculate the number of flipped cards
    
    func countNumberOfFlippedCards()->Int{
        
        var num = 0
        
        for cardButton in cardButtons {
            
            guard let index = cardButtons.index(of: cardButton) else {
                return 0
            }
            
            guard let card =  gameMatchManager.cardAtIndex(index) else {
                return 0
            }
            
            if card.isSelected == true {
                
                num = num + 1
                
                // Save information which indices and cards are selected
                selectedCards.append(card)
                buttonIndices.append(index)
            }
        }
        
        return num
    }
    
    // MARK : Place flipped cards face down
    
    func placeFippedCardsFaceDown() {
        
        let time = DispatchTime.now() + Double(Int64(Constants.DelayIfNotMathced * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time) {
            
            // If there are more than two cards selected
            if ( self.buttonIndices.count >= 2 ) {
                
                // iterates through the number of selected cards
                for i in 0..<self.selectedCards.count {
                    
                    // Set as not selected
                    self.selectedCards[i].isSelected = false
                    
                    // Update Card background image as default image
                    let imageName = self.getBackgroundImage(self.selectedCards[i])
                    self.cardButtons[self.buttonIndices[i]].setBackgroundImage(UIImage(named:imageName), for: UIControlState())
                    
                }
            }
            
            // Initialize both arrays
            self.initializeSelectedCardAndButtonIndicesArray()
        }
        
    }
    
    
    // MARK : Get Background Image of Card
    
    func getBackgroundImage(_ card:Card)->String {
        
        if (card.isSelected == true) {
            return card.colourDesc
        }else {
            return Constants.BackGroundImageName
        }
        
    }
    
    // MARK : Show AlertView
    
    func showAlert()
    {
        let title   = Constants.AlertTitle
        let message = Constants.AlertMessage
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let placeholder = Constants.AlertPlaceholder
        
        // Adds a text field to an alert
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            textField.placeholder = placeholder
            // Associate target object with action 'textChanged:' when a control event occurs
            // textField.addTarget(self, action: #selector(GameBoardViewController.textChanged(_:)), forControlEvents: .EditingChanged)
            textField.addTarget(self, action: #selector(GameBoardViewController.textChanged(_:)), for: .editingChanged)
        })
        
        // Define action when 'Cancle' button tapped
        let cancel = UIAlertAction(title: Constants.ActionCancel, style: UIAlertActionStyle.cancel, handler: { (_) -> Void in
            self.resetGame()
        })
        
        // Define action when 'Ok' button tapped
        let ok = UIAlertAction(title: Constants.ActionOk, style: UIAlertActionStyle.default, handler: { (_) -> Void in
            
            // Get the first element of textField array
            let textfield = alert.textFields!.first!
            
            // Get User Name
            self.userName = textfield.text!
            
            // Save the current user's score
            self.userScore = self.gameMatchManager.getScore()
            
            // Processing the game result
            self.processGameResult()
            
            self.performSegue(withIdentifier: Constants.Segue.ShowScoreVCWithExtraInformation, sender: self)
        })
        
        // Add actions
        alert.addAction(cancel)
        alert.addAction(ok)
        
        actionToEnable = ok
        
        // Disabled OK button initially
        ok.isEnabled = false
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK : TextField Action Method
    
    func textChanged(_ sender:UITextField) {
        
        // Once text is entered, UIAlertAction becomes enabled
        actionToEnable?.isEnabled = (sender.text! != "")
    }
    
    // MARK : Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // if segue to the highscoretable viewcontroller after playing game
        if segue.identifier == Constants.Segue.ShowScoreVCWithExtraInformation {
            
            let highScoreVC = segue.destination as? HighScoreTableViewController
            highScoreVC?.score = userScore
            highScoreVC?.rank  = rank
            highScoreVC?.highScoreList = scoreList
            
        } else if segue.identifier == Constants.Segue.ShowScoreVCWithTableOnly {
            // if segue to the highscoretable viewcontroller after tapping highscore button without playing game
            let highScoreVC = segue.destination as? HighScoreTableViewController
            highScoreVC?.highScoreList = scoreList
            
            
        }
    }
}


// MARK : - Dictionary ( Subscripting support )

extension Dictionary {
    
    // MARK : Subscripting Dictionary By Index
    subscript(i:Int) -> (key:Key,value:Value) {
        get {
            return self[self.index(self.startIndex, offsetBy: i)]
        }
    }
    
}

