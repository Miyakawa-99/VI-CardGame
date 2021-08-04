//
//  File.swift
//  iOS-MultipeerConnectivity
//これ直す
//  Created by miyakawa haruna on 2019/04/30.
//  Copyright © 2019 hryk224. All rights reserved.
//


import Foundation

class Card {
    
    //var shuffle: = ChatViewController.shuffleArray
    var Order: [Int]!
    var anArray = [0,1,2,3,4,5]
    var texts: [(order: Int, name: String , name_number: Int)]!
    
    func card_init() -> [(order: Int, name: String , name_number: Int)]{
        for i in 0 ..< anArray.count{
            let r = Int(arc4random_uniform(UInt32(anArray.count)))
            anArray.swapAt(i, r)
        }
        print("shuffle後")
        for i in anArray{
            print("\(i)")
        }
        
        texts = [
            //order:順番 name: 音
            (anArray[0] , "Cat" , 0),
            (anArray[1] , "Dog" , 1),
            (anArray[2], "Elephant" , 2),
            (anArray[3], "Cow" ,3),
            (anArray[4], "Lion" ,4),
            (anArray[5], "Monkey" ,5),
            //(anArray[6], "Sheep" ,6),
            //(anArray[7], "rain" ,7)
            
        ]
        //return texts.order.sort { $0 < $1 }
        return texts
        
    }
    
    //必要？
    func player_init() -> [(order: Int, name: String)]{
        
        var after_player: [(order: Int?, name: String)] = [
            //order:順番 name: 音
            /*(0 , "Hikaru" ),
            (1 , "Kenta" ),
            (2, "Kota" ),
            (3, "Nosuke" )*/
            (texts[anArray[0]].name_number , "Kota" ),
            (texts[anArray[1]].name_number , "Yuji" ),
            (texts[anArray[2]].name_number, "Yuto" ),
            (texts[anArray[3]].name_number, "Yoshihisa" ),
            (texts[anArray[4]].name_number , "Hikaru" ),
            (texts[anArray[5]].name_number , "riu" ),
            
        ]
            
        return after_player as! [(order: Int, name: String)]
        
    }
    func conversion(SoundName: String) -> Int{
        switch SoundName {
        
        case "Cat":
            return 0
        
        case "Dog":
            return 1
        
        case "Elephant":
            return 2
        
        case "Cow":
            return 3
        
        case "Lion":
            return 4
        
        case "Monkey":
            return 5
            
        /*case "minminzemi-cry":
            return 6
            
        case "rain":
            return 7*/
            
        default:
            return -1
        }
    }
}
