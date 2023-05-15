//
//  ViewController2.swift
//  BlackJacko
//
//  Created by Joseph Wong on 19/2/2023.
//

import UIKit

var Wallet = 1000

class ViewController2: UIViewController {

    @IBOutlet weak var Dealer1: UIImageView!
    @IBOutlet weak var Dealer2: UIImageView!
    @IBOutlet weak var Dealer3: UIImageView!
    @IBOutlet weak var Dealer4: UIImageView!
    
    @IBOutlet weak var Player1: UIImageView!
    @IBOutlet weak var Player2: UIImageView!
    @IBOutlet weak var Player3: UIImageView!
    @IBOutlet weak var Player4: UIImageView!
    
    @IBOutlet weak var InfoLabel: UILabel!
    
    @IBOutlet weak var WalletLabel: UILabel!
    
    @IBOutlet weak var BetInput: UITextField!
    
    @IBOutlet weak var BetAmount: UILabel!
    
    var isPlaying = false
    
    var playernum = 0
    var dealernum = 0
    
    var numCLicks = 0
    var betamount = 0
    
    var cardArr = [String]() //card array to store all player cards
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WalletLabel.text = "Wallet: " + String(Wallet)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BET(_ sender: Any) {
        betamount = Int(BetInput.text!)!
        
        if (isPlaying == false){
            if (Wallet >= betamount){
                BetAmount.text = "Bet amount: " + String(betamount)
            }
            else{
                InfoLabel.text = "Not enough Money."
                betamount = 0
                BetAmount.text = "Bet amount: " + String(betamount)
            }
            WalletLabel.text = "Wallet: " + String(Wallet)
        }
        else{
            
        }
       
    }
    
    func Win(){
        Wallet += betamount * 2
        WalletLabel.text = "Wallet: " + String(Wallet)
    }
    
    func TIED(){
        // adds back since wallet is already deducted for betamount as to prevent possible exploits
        Wallet += betamount
        WalletLabel.text = "Wallet: " + String(Wallet)
    }
    
    func Lost(){
        // nothing since wallet is already deducted for betamount as to prevent possible exploits
    }
    
    @IBAction func HIT(_ sender: Any) {
        print("player: \(String(playernum))")
        print("dealer: \(String(dealernum))")
        
        if (isPlaying == true && playernum <= 21 && numCLicks >= 0 && numCLicks < 4){
            if (numCLicks == 2){
                Player3.image = UIImage(named: cardGen(user: 0))
                CheckIfBust()
                numCLicks += 1
            }
            else if (numCLicks == 3){
                Player4.image = UIImage(named: cardGen(user: 0))
                CheckIfBust()
                numCLicks += 1
            }
            else{ //base
                InfoLabel.text = "You Lost."
            }
        }
    }
    @IBAction func STAND(_ sender: Any) {
        if (isPlaying == true && playernum <= 21){
            
            print("player SCORE1: " + String(playernum))
            print("bot SCORE1: " + String(dealernum))
            
            // ending
            Dealer2.image = UIImage(named: cardGen(user: 1))
            if (dealernum > playernum && dealernum <= 21){
                InfoLabel.text = "You Lost."
            }
            else if ( dealernum > 21){
                InfoLabel.text = "You WIN!"
                Win()
            }
            else if ( dealernum == playernum && dealernum >= 17){
                InfoLabel.text = "You TIE."
                TIED()
            }
            else if (dealernum < playernum && dealernum >= 16){
                    InfoLabel.text = "You WIN!"
                Win()
            }
            else if (dealernum <= playernum && dealernum < 17){ //chained 3
                Dealer3.image = UIImage(named: cardGen(user: 1))
                
                if (dealernum > playernum && dealernum < 22){
                    InfoLabel.text = "You Lost."
                }
                else if (dealernum == playernum && dealernum <= 21 && dealernum > 16){
                    InfoLabel.text = "You TIE."
                    TIED()
                }
                else if ( dealernum > 21){
                    InfoLabel.text = "You WIN!"
                    Win()
                }
                else if (dealernum <= playernum && dealernum < 17){ //chain 4
                    Dealer4.image = UIImage(named: cardGen(user: 1))
                    
                    if (dealernum > playernum && dealernum < 22){
                        InfoLabel.text = "You Lost."
                    }
                    else if (dealernum == playernum && dealernum <= 21){
                        InfoLabel.text = "You TIE."
                        TIED()
                    }
                    else if (dealernum < playernum){
                        InfoLabel.text = "You WIN!"
                        Win()
                    }
                    else if (dealernum >= 22){
                        InfoLabel.text = "You WIN!"
                        Win()
                    }
                    
                }
                else if (dealernum < playernum && dealernum >= 17){
                    InfoLabel.text = "You WIN!"
                    Win()
                }
                
            }
            print("player SCORE2: " + String(playernum))
            print("bot SCORE2: " + String(dealernum))
            
            
        }
    }
    
    func CheckIfBust(){
        print("player SCORE: " + String(playernum))
        print("bot SCORE: " + String(dealernum))
        if (playernum > 21){
            InfoLabel.text = "You Busted! 😫"
        }
        else{
            InfoLabel.text = "Press HIT or STAND!"
        }
    }
    
    //START BUTTON
    @IBAction func Deal(_ sender: Any) {
        
        // only used if not playing to prevent multiple deals
        if (isPlaying == false){
            isPlaying = true
            
            Wallet -= betamount //minus from wallet
            WalletLabel.text = "Wallet: " + String(Wallet)
            
            //resetter
            playernum = 0
            dealernum = 0
            
            // Card set ups
            Dealer1.image = UIImage(named: cardGen(user: 1))
            
            Player1.image = UIImage(named: cardGen(user: 0))
            Player2.image = UIImage(named: cardGen(user: 0))
            
            numCLicks = 2
            
            //base casers
            CheckIfBust()
            
        }
        
    }

    //user: 1 - bot, 0 - player
    func cardGen(user: Int) -> String {
        
        var working = true
        
        var ace_helper_var = -1
        // if 0: ace = 11
        // if 1: ace = 1
        // if -1: neither
        
        while (working){
            var card = ""
            let randomNumber = Int.random(in: 2...14)
            
            if (user == 0){
                print("plauyer in use")
            }
            
            if (randomNumber <= 10){
                card = String(randomNumber)
                if (user == 0){
                    playernum += randomNumber
                }
                else{
                    dealernum += randomNumber
                }
            }
            else if (randomNumber == 11)
            {
                if (user == 0){
                    playernum += 10
                }
                else{
                    dealernum += 10
                }
                card = "j"
            }
            else if (randomNumber == 12)
            {
                if (user == 0){
                    playernum += 10
                }
                else{
                    dealernum += 10
                }
                card = "q"
            }
            else if (randomNumber == 13)
            {
                if (user == 0){
                    playernum += 10
                }
                else{
                    dealernum += 10
                }
                card = "k"
            }
            else if (randomNumber == 14)
            {
                //adds 11 or 1
                if (user == 0){
                    if (playernum > 10){
                        playernum += 1
                        ace_helper_var = 1
                    }
                    else{
                        playernum += 11
                        ace_helper_var = 0
                    }
                }
                else{
                    if (dealernum > 10){
                        dealernum += 1
                        ace_helper_var = 1
                    }
                    else{
                        dealernum += 11
                        ace_helper_var = 0
                    }
                }
                card = "a"
            }
            
            
            // suit type generator
            let randomSuitNumber = Int.random(in: 1...4)
            if (randomSuitNumber == 4){
                card += "d"
            }
            else if (randomSuitNumber == 3){
                card += "c"
            }
            else if (randomSuitNumber == 2){
                card += "h"
            }
            else if (randomSuitNumber == 1){
                card += "s"
            }
            
            cardArr.append(card)
            
            // checks for duplicate redundancies using the arrays
            var count = 0
            for i in Range(0...cardArr.count - 1) {
                if (cardArr[i] == card){
                    count += 1
                }
            }
            
            if (count == 1){ //if there are no duplicates then end while loop
                working = false
            }
            else if (count > 1){ //if there are no duplicates then redraw
                
//                print("DUPLICATE APPEARED")
                //working stays true
                // remove last drawn (dupped) card
                cardArr.removeLast()
                
                if (randomNumber <= 10){
                    if  (user == 0){
                        playernum -= randomNumber
                    }
                    else{
                        dealernum -= randomNumber
                    }
                }
                else if (randomNumber == 12 || randomNumber == 11 || randomNumber == 13){
                    if  (user == 0){
                        playernum -= 10
                    }
                    else{
                        dealernum -= 10
                    }
                }
                else if (randomNumber == 14){ //todo
                    if (ace_helper_var == 1){
                        if  (user == 0){
                            playernum -= 11
                        }
                        else{
                            dealernum -= 11
                        }
                    }
                    else if (ace_helper_var == 0){
                        if  (user == 0){
                            playernum -= 11
                        }
                        else{
                            dealernum -= 11
                        }
                    }
                }
//                else{
//                    playernum -= 10
//                }
                
            }
        }

        return cardArr[cardArr.count - 1]
    }
    
    @IBAction func RESET(_ sender: Any) {
        isPlaying = false
        playernum = 0
        dealernum = 0
        numCLicks = 0
        betamount = 0
        
        BetAmount.text = "Bet amount: " + String(betamount)
        
        Dealer1.image = UIImage(named: "none")
        Dealer2.image = UIImage(named: "none")
        Dealer3.image = UIImage(named: "none")
        Dealer4.image = UIImage(named: "none")
        
        Player1.image = UIImage(named: "none")
        Player2.image = UIImage(named: "none")
        Player3.image = UIImage(named: "none")
        Player4.image = UIImage(named: "none")
        
        InfoLabel.text = "Press Deal to start."
        
        // reset card list
        cardArr.removeAll()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
