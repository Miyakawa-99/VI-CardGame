//
//  ViewController.swift
//  iOS-MultipeerConnectivity
//親10
//  Created by hryk224 on 2017/12/10.
//  Copyright © 2017年 hryk224. All rights reserved.
//

import MultipeerConnectivity
import Photos
import UIKit

final class ChatViewController: UIViewController{
    var sound = Sound()
    var number: Int! = 0
    var Karuta = Card()
    var card_tupple: [(order: Int, name: String , name_number: Int)]!
    var card = [0,0,0,0,0,0]
    //var player_tupple: [(order: Int, name: String)]!
    var CorrectCard: String?
    var TappedCard: String?
    var TappedPlayer: String?
    var Tappedindex: Int?
    var Time: String?
    var Decision: String?
    var isFirst: Bool = true
    var isLast: Bool = false
    var dummy:Bool = false
    typealias player = (order: Int, name: String)
    var player_tupple = [player]()
    //var view = ViewController()

    //@IBOutlet weak var textField: UITextField!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet fileprivate weak var toolBarBottomConstraint: NSLayoutConstraint!

    private let sessionContainer: SessionContainer = {
        return .init(displayName: Const.displayName, serviceType: Const.serviceType)
    }()

    @IBAction func browseForPeers(_ sender: UIBarButtonItem) {
        let browserViewController: MCBrowserViewController = .init(serviceType: Const.serviceType, session: sessionContainer.session)
        browserViewController.delegate = self
        browserViewController.minimumNumberOfPeers = kMCSessionMinimumNumberOfPeers
        browserViewController.maximumNumberOfPeers = kMCSessionMaximumNumberOfPeers
        present(browserViewController, animated: true, completion: nil)
        
        //ピアの検索.ピアのリスト表示.接続要求の送信.接続の確立
        //接続要求を送信

    }

    
    //送信側の吹き出し部分のテキスト＝textField.text
    @IBAction func sendMessage(_ sender: UIBarButtonItem) {
        sessionContainer.sendMessage("send")
  
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        sessionContainer.delegate = self
        title = ""
    }

    ///読み札決定ボタン挙動
  //ここなんかフィードバック欲しい
    @IBAction func Decide(_ sender: UIButton) {
        print("send")
        
        sessionContainer.sendMessage("send")
        //timer start
        if(isLast == false){
          self.sound.playSound(name: CorrectCard!)
          self.sound.play()
        
            sessionContainer.sendMessage(String(Karuta.conversion(SoundName: CorrectCard!)))
        
          DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.sound.stop()
             }
        }
        else{
            let random = arc4random_uniform(5)
            CorrectCard = self.card_tupple[self.card_tupple[Int(random)].order].name
            self.sound.playSound(name: String(self.card_tupple[self.card_tupple[Int(random)].order].name))
            self.sound.play()
            
            sessionContainer.sendMessage(String(Karuta.conversion(SoundName: self.card_tupple[self.card_tupple[Int(random)].order].name)))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.sound.stop()
            }
            
        }
        //音鳴らす
        
        
    }
 
  ///今ある札確認するよー
    @IBAction func Device(_ sender: Any) {
        if isFirst {
            card_tupple = Karuta.card_init()
            player_tupple = Karuta.player_init()
            isFirst = false
        }
        sessionContainer.sendMessage("Serch_Device")
        print("SERCH")
        
    }
    
    @IBOutlet weak var Card1: UIButton! {
        didSet {
            Card1.isHidden = true
        }
    }
    @IBOutlet weak var Card2: UIButton! {
        didSet {
            Card2.isHidden = true
        }
    }
    @IBOutlet weak var Card3: UIButton! {
        didSet {
            Card3.isHidden = true
        }
    }
    @IBOutlet weak var Card4: UIButton! {
        didSet {
            Card4.isHidden = true
        }
    }
    @IBOutlet weak var Card5: UIButton! {
        didSet {
            Card5.isHidden = true
        }
    }
    @IBOutlet weak var Card6: UIButton! {
        didSet {
            Card6.isHidden = true
        }
    }
    @IBOutlet weak var Kota: UIButton!
    @IBOutlet weak var Yuji: UIButton!
    @IBOutlet weak var Yuto: UIButton!
    @IBOutlet weak var Yoshihisa: UIButton!
    @IBOutlet weak var Hikaru: UIButton!
    @IBOutlet weak var Takahiro: UIButton!
    
    
    @IBAction func Kota_action(_ sender: Any) {
        sessionContainer.sendMessage(String(Kota.currentTitle!) + "_player")
        print(String(Kota.currentTitle!) + "_player")
    }
    @IBAction func Yuji_action(_ sender: Any) {
        sessionContainer.sendMessage(String(Yuji.currentTitle!) + "_player")
        print(String(Yuji.currentTitle!) + "_player")
    }
    
    @IBAction func Yuto_action(_ sender: Any) {
        sessionContainer.sendMessage(String(Yuto.currentTitle!) + "_player")
        print(String(Kota.currentTitle!) + "_player")
    }
    
    @IBAction func Yoshihisa_action(_ sender: Any) {
        sessionContainer.sendMessage(String(Yoshihisa.currentTitle!) + "_player")
        print(String(Kota.currentTitle!) + "_player")
    }
    @IBAction func Hikaru_action(_ sender: Any) {
        sessionContainer.sendMessage(String(Hikaru.currentTitle!) + "_player")
        print(String(Kota.currentTitle!) + "_player")
    }
    @IBAction func Takahiro_action(_ sender: Any) {
        sessionContainer.sendMessage(String(Takahiro.currentTitle!) + "_player")
        print(String(Kota.currentTitle!) + "_player")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ViewController") {
            let vc2: ViewController = (segue.destination as? ViewController)!
            // ViewControllerのtextVC2にメッセージを設定
            vc2.CorrectCard_text = CorrectCard
            vc2.Time_text = Time
            vc2.TappedCard_text = TappedCard
            vc2.Decision_text = Decision
            
        }
    }

    @IBAction func Card1_action(_ sender: Any) {
        if(self.card[self.Karuta.conversion(SoundName: self.Card1.currentTitle!)] == 1){
            dummy = true
            self.sessionContainer.sendMessage("dummy")
            print("dummy")
        }
        CorrectCard = Card1.currentTitle
        self.Card1.backgroundColor = UIColor.blue
        self.Card2.backgroundColor = UIColor.groupTableViewBackground
        self.Card3.backgroundColor = UIColor.groupTableViewBackground
        self.Card4.backgroundColor = UIColor.groupTableViewBackground
        self.Card5.backgroundColor = UIColor.groupTableViewBackground
        self.Card6.backgroundColor = UIColor.groupTableViewBackground
    }
    @IBAction func Card2_action(_ sender: Any) {
        if(self.card[self.Karuta.conversion(SoundName: self.Card2.currentTitle!)] == 1){
            dummy = true
            self.sessionContainer.sendMessage("dummy")
            print("dummy")
        }
        CorrectCard = Card2.currentTitle
        self.Card1.backgroundColor = UIColor.groupTableViewBackground
        self.Card2.backgroundColor = UIColor.blue
        self.Card3.backgroundColor = UIColor.groupTableViewBackground
         self.Card4.backgroundColor = UIColor.groupTableViewBackground
        self.Card5.backgroundColor = UIColor.groupTableViewBackground
        self.Card6.backgroundColor = UIColor.groupTableViewBackground
    }
    @IBAction func Card3_action(_ sender: Any) {
        if(self.card[self.Karuta.conversion(SoundName: self.Card3.currentTitle!)] == 1){
            dummy = true
            self.sessionContainer.sendMessage("dummy")
            print("dummy")
        }
        CorrectCard = Card3.currentTitle
        self.Card1.backgroundColor = UIColor.groupTableViewBackground
        self.Card2.backgroundColor = UIColor.groupTableViewBackground
        self.Card3.backgroundColor = UIColor.blue
         self.Card4.backgroundColor = UIColor.groupTableViewBackground
        self.Card5.backgroundColor = UIColor.groupTableViewBackground
        self.Card6.backgroundColor = UIColor.groupTableViewBackground
    }
    @IBAction func Card4_action(_ sender: Any) {
        if(self.card[self.Karuta.conversion(SoundName: self.Card4.currentTitle!)] == 1){
            dummy = true
            self.sessionContainer.sendMessage("dummy")
            print("dummy")
        }
        CorrectCard = Card4.currentTitle
        self.Card1.backgroundColor = UIColor.groupTableViewBackground
        self.Card2.backgroundColor = UIColor.groupTableViewBackground
        self.Card3.backgroundColor = UIColor.groupTableViewBackground
         self.Card4.backgroundColor = UIColor.blue
        self.Card5.backgroundColor = UIColor.groupTableViewBackground
        self.Card6.backgroundColor = UIColor.groupTableViewBackground
    }
    
    @IBAction func Card5_action(_ sender: Any) {
        if(self.card[self.Karuta.conversion(SoundName: self.Card5.currentTitle!)] == 1){
            dummy = true
            self.sessionContainer.sendMessage("dummy")
            print("dummy")
        }
        CorrectCard = Card5.currentTitle
        self.Card1.backgroundColor = UIColor.groupTableViewBackground
        self.Card2.backgroundColor = UIColor.groupTableViewBackground
        self.Card3.backgroundColor = UIColor.groupTableViewBackground
        self.Card4.backgroundColor = UIColor.groupTableViewBackground
        self.Card5.backgroundColor = UIColor.blue
        self.Card6.backgroundColor = UIColor.groupTableViewBackground
    }
    
    @IBAction func Card6_action(_ sender: Any) {
        if(self.card[self.Karuta.conversion(SoundName: self.Card6.currentTitle!)] == 1){
            dummy = true
            self.sessionContainer.sendMessage("dummy")
            print("dummy")
        }
        CorrectCard = Card6.currentTitle
        self.Card1.backgroundColor = UIColor.groupTableViewBackground
        self.Card2.backgroundColor = UIColor.groupTableViewBackground
        self.Card3.backgroundColor = UIColor.groupTableViewBackground
        self.Card4.backgroundColor = UIColor.groupTableViewBackground
        self.Card5.backgroundColor = UIColor.groupTableViewBackground
        self.Card6.backgroundColor = UIColor.blue
    }
  
    func insertTranscript(_ transcript: Transcript) {
        
        switch transcript.message {
        case "dummy":
            self.sound.playSound(name: "Wrong")
            self.sound.play()
            self.sessionContainer.sendMessage("miss")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.sound.stop()
            }
        //case "Correct":
           // transcript_message = "Correct"
            //カードタップされた時処理
        case "0","1","2","3","4","5","6","7":// 直さなきゃ
            
            Tappedindex = player_tupple.index(where: {$0.order == Int(transcript.message)})
            TappedPlayer = player_tupple[Tappedindex!].name//print("a")
            
            DispatchQueue.main.async {
                self.TappedCard = String(self.card_tupple[Int(transcript.message)!].name)
                

                if let name = self.TappedCard {
                 if(self.TappedCard  == self.CorrectCard){
                    self.card[self.Karuta.conversion(SoundName: self.CorrectCard!)] = 1
                    
                    /////change
                    //カード消す作業
                    /*if(self.Card1.currentTitle == self.CorrectCard){
                        self.Card1.isHidden = true
                    }
                    if(self.Card2.currentTitle == self.CorrectCard){
                        self.Card2.isHidden = true
                    }
                    if(self.Card3.currentTitle == self.CorrectCard){
                        self.Card3.isHidden = true
                    }
                    if(self.Card4.currentTitle == self.CorrectCard){
                        self.Card4.isHidden = true
                    }
                    if(self.Card5.currentTitle == self.CorrectCard){
                        self.Card5.isHidden = true
                    }
                    if(self.Card6.currentTitle == self.CorrectCard){
                        self.Card6.isHidden = true
                    }*/
                    //self.Card4.isHidden = true
                    
                    self.sessionContainer.sendMessage(String(self.Karuta.conversion(SoundName: self.CorrectCard!)))
                    //合ってたら音鳴らす挙動のため
                    
                    self.Decision = "CORRECT"
                    self.sound.playSound(name: "Correct")
                    self.sound.play()
                    
                    self.sessionContainer.sendMessage(String(self.TappedPlayer!) + "_player" )
                    //子デバイスのカード配列から不要カード消去するため
                    
                    print(String(self.TappedPlayer!))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.sound.stop()
                    }
                   
                }
              else {
                    self.Decision = "FALSE"
                    self.sound.playSound(name: "Wrong")
                    self.sound.play()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.sound.stop()
                    }
               }
        
            }
                self.performSegue(withIdentifier: "ViewController",sender: nil)
            }///消してみた
        //カード選んだ
        case "Yuji" , "Kota" , "Yuto","Yoshihisa","riu","Hikaru":
            number = number + 1
            //print(number)
            switch transcript.message{
            case "Kota":
                print("case1")
                
                sessionContainer.sendMessage(String(card_tupple[0].order))
                print(String(card_tupple[0].order))
                print(String(self.card_tupple[self.card_tupple[0].order].name))
                DispatchQueue.main.async {
                    self.Card1.setTitle(String(self.card_tupple[self.card_tupple[0].order].name), for:UIControl.State.normal)
                    self.Card1.isHidden = false
                }
            case "Yuji":
                print("case2")
                //sessionContainer.sendMessage(transcript.message)//追加
                //Thread.sleep(forTimeInterval: 5.0)
                //待機？
                sessionContainer.sendMessage(String(card_tupple[1].order))
                print(String(card_tupple[1].order))
                print(String(self.card_tupple[self.card_tupple[1].order].name))
                DispatchQueue.main.async {
                    self.Card2.setTitle(String(self.card_tupple[self.card_tupple[1].order].name), for:UIControl.State.normal)
                    self.Card2.isHidden = false
                }
            case "Yuto":
                print("case3")
                sessionContainer.sendMessage(String(card_tupple[2].order))
                print(String(card_tupple[2].order))
                print(String(self.card_tupple[self.card_tupple[2].order].name))
                
                DispatchQueue.main.async {
                    self.Card3.setTitle(String(self.card_tupple[self.card_tupple[2].order].name), for:UIControl.State.normal)
                    self.Card3.isHidden = false
                }
            case "Yoshihisa":
                print("case4")
                sessionContainer.sendMessage(String(card_tupple[3].order))
                print(String(card_tupple[3].order))
                print(String(self.card_tupple[self.card_tupple[3].order].name))
                
                DispatchQueue.main.async {
                    self.Card4.setTitle(String(self.card_tupple[self.card_tupple[3].order].name), for:UIControl.State.normal)
                    self.Card4.isHidden = false
                }
            case "Hikaru":
                print("case5")
                sessionContainer.sendMessage(String(card_tupple[4].order))
                print(String(card_tupple[4].order))
                print(String(self.card_tupple[self.card_tupple[4].order].name))
                
                DispatchQueue.main.async {
                    self.Card5.setTitle(String(self.card_tupple[self.card_tupple[4].order].name), for:UIControl.State.normal)
                    self.Card5.isHidden = false
                }
            case "riu":
                print("case6")
                sessionContainer.sendMessage(String(card_tupple[5].order))
                print(String(card_tupple[5].order))
                print(String(self.card_tupple[self.card_tupple[5].order].name))
                
                DispatchQueue.main.async {
                    self.Card6.setTitle(String(self.card_tupple[self.card_tupple[5].order].name), for:UIControl.State.normal)
                    self.Card6.isHidden = false
                }
            default:
                print("default")
            }
        case "last":
            print("last")
            //isLast = true//change
            //card_tupple = Karuta.card_init()
        default:
            print("default")//消してみた
            DispatchQueue.main.async {
                self.Time = String(transcript.message)
                self.performSegue(withIdentifier: "ViewController",sender: nil)
            }
            
    }
  }
}

extension ChatViewController: SessionContainerDelegate {

    func sessionContainer(received transcript: Transcript) {
        insertTranscript(transcript)
    }

}

// MARK: - MCBrowserViewControllerDelegate
extension ChatViewController: MCBrowserViewControllerDelegate {

    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true, completion: nil)
    }

    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true, completion: nil)
    }

    func browserViewController(_ browserViewController: MCBrowserViewController, shouldPresentNearbyPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) -> Bool {
        return true
    }

}
