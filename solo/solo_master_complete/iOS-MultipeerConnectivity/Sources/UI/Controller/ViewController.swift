//
//  ViewController.swift
//  iOS-MultipeerConnectivity
//
//  Created by miyakawa haruna on 2019/05/01.
//  Copyright © 2019 hryk224. All rights reserved.
//
import MultipeerConnectivity
import Photos
import UIKit

class ViewController: UIViewController {
    
    var AA: Int?
    var AB: Int?
    //var Time: String?
    //var Decision: String?
    
    @IBOutlet weak var Correct_card: UITextField!
    @IBOutlet weak var Tapped_card: UITextField!
    @IBOutlet weak var Time: UITextField!
    @IBOutlet weak var Decision: UITextField!
    
    @IBOutlet weak var Acount: UITextField!
    @IBOutlet weak var Bcount: UITextField!
    @IBOutlet weak var A: UIStepper!
    @IBOutlet weak var B: UIStepper!
    
    @IBAction func finish(_ sender: Any) {
         self.performSegue(withIdentifier: "FinalController",sender: nil)
    }
    
    @IBAction func pointA(_ sender: Any) {
        AA = 1
    }
    
    @IBAction func pointB(_ sender: Any) {
        AB = 1
    }
    
    @IBAction func A_tap(_ sender: Any) {
        Acount.text = String(A.value)
    }
    @IBAction func B_tap(_ sender: Any) {
        Bcount.text = String(B.value)
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "FinalController") {
          let vc2: Final = (segue.destination as? Final)!
     // FinalのtextVC2にメッセージを設定
          vc2.A_Point = AA
          vc2.B_Point = AB
          //vc2.TappedCard_text = TappedCard
          //vc2.Decision_text = Decision
       
          }
     }
  
    var CorrectCard_text: String?
    var TappedCard_text: String?
    var Time_text: String?
    var Decision_text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //card_tupple = Karuta.card_init()
        Correct_card.text = CorrectCard_text
        Tapped_card.text = TappedCard_text
        Time.text = Time_text
        Decision.text = Decision_text
        // Do any additional setup after loading the view.
    }
    
    }
            /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    


