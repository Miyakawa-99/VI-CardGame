//
//  File.swift
//  iOS-MultipeerConnectivity
//
//  Created by miyakawa haruna on 2019/05/19.
//  Copyright © 2019 hryk224. All rights reserved.
//

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

class Final: UIViewController {

    @IBOutlet weak var Acount: UITextField!
    @IBOutlet weak var Bcount: UITextField!
 
    var A_Point: Int?
    var B_Point: Int?
    var A: Int = 0
    var B: Int = 0
    //var Time_text: String?
    //var Decision_text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(A_Point == 1){
            A = A + 1
        //card_tupple = Karuta.card_init()
         // Acount.text = String(A_Point)
        }
        if(B_Point == 1){
            B = B + 1
        }
        Acount.text = String(A)
        Bcount.text = String(B)
     
    }
    
//}
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.*/
    
 }
 
 
 


