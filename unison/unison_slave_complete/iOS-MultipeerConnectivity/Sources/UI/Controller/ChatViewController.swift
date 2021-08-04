//
//  ViewController.swift
//  iOS-MultipeerConnectivity
//子9
//  Created by hryk224 on 2017/12/10.
//  Copyright © 2017年 hryk224. All rights reserved.
//

import MultipeerConnectivity
import UIKit
import AVFoundation
final class ChatViewController: UIViewController,UIGestureRecognizerDelegate{
    var sound = Sound()//追加
    var timer = Timer()
    var startTime: TimeInterval = 0
    var elapsedTime: Double = 0.0
    var time: Double = 0.0
    var flag: Bool = false
    var flag_2: Bool = false
    var last:Bool = false
    var remove:Bool = false
    var tap:Bool = false
    var dummy:Bool = false
    var mySound: String?
    var correctSound: String?
    var transcript_message: String?
    var player: [String] = ["Kota_player","Yuji_player","Yuto_player","Yoshihisa_player","Hikaru_player","riu_player"]
    var Time: Double?
    var str: Double?
    
    
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
        
        //sessionContainer.sendMessage(Const.soundName)
        //ピアの検索.ピアのリスト表示.接続要求の送信.接続の確立
        //接続要求を送信
        
    }
    
    @IBAction func Tap(_ sender: UITapGestureRecognizer) {
        //print("aaa")
        if dummy{
            sessionContainer.sendMessage("dummy")
            dummy = false
            //self.sound.playSound(name: "Wrong")
            //self.sound.play()
            //DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                //self.sound.stop()
            //}
                //self.sound.stop()
        }
        timer.invalidate()
        elapsedTime = time
        print(elapsedTime)
        tap = true
        //送る
        
        if(correctSound == mySound){
            flag_2 = true
            sessionContainer.sendMessage(String(elapsedTime))
            sessionContainer.sendMessage(String(mySound!))
        //sound.play()
             //もう捨て札
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.sound.stop()
        }
        }
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sessionContainer.sendMessage(Const.soundName)
        sessionContainer.delegate = self
        title = ""
        
    }
    
 //多分テキスト表示
    func insertTranscript(_ transcript: Transcript) {
        switch transcript.message {
        //case "Correct":
           // transcript_message = "Correct"
        case "send":
            if last{
                let random = arc4random_uniform(6)//取り札ラスト
                sound.playSound(name: mySound!)
                mySound = String(random)
            }
            
            //sound.playSound(name: Const.soundName)//追加
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                //self.sessionContainer.sendMessage(Const.displayName)
                //self.flag = true
                //print("TRUE")
            self.sound.play()
            self.startTime = Date().timeIntervalSince1970
            print("TimerStart")
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                
                self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            }
            }
            //print("sound")
        case "Serch_Device":
            print("SERCH")
            
            
            Time = 6.0 * Double((player.index(of: Const.displayName + "_player")!))
            DispatchQueue.main.asyncAfter(deadline: .now() + Time!) {
                self.sessionContainer.sendMessage(Const.displayName)
                self.flag = true
                print("TRUE")
            }
    
            
        case "0","1","2","3","4","5","6","7":
            if(flag == true){
                //if(Const.displayName == transcript.message){
                mySound = transcript.message
                print(mySound!)
                sound.playSound(name: mySound!)
                           sound.play()
                flag = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.sound.stop()
                       // }
                }
            }
            else{
                print("notNow")
                correctSound = transcript.message
                //最終的に正しいカードが送られてくるよね
            }//////
        case "stop":
            if(flag_2 == false) {//なぜか止まらない時あるの
              sound.stop()
            }
        case "dummy":
            dummy = true
            
        case "finish":
            if flag_2 {
                exit(0)
            }
        case "miss":
            sound.stop()
       /////追加
        case "Yuji_player" , "Kota_player" , "Yuto_player","Yoshihisa_player","riu_player","Hikaru_player":
            print(transcript.message)
            if (remove == false){
                player.remove(at: player.index(of: transcript.message)!)
                remove = true
            }
            //もし残り一枚だったら？
            if(player.count == 1){
                sessionContainer.sendMessage("last")
                last = true
            }
            
            print(player)
         
       default:
            print ("default")
        }
 
    }
    
    @objc func update() {
        // (現在の時刻 - Startボタンを押した時刻) + Stopボタンを押した時点で経過していた時刻
        time = Date().timeIntervalSince1970 - startTime + elapsedTime
        //print("update")
        print(time)
    }
}



// MARK: - SessionContainerDelegate
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
