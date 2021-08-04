//
//  SessionContainer.swift
//  iOS-MultipeerConnectivity
//親
//  Created by hryk224 on 2017/12/10.
//  Copyright © 2017年 hryk224. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol SessionContainerDelegate: class {
    func sessionContainer(received transcript: Transcript)
}

final class SessionContainer: NSObject {

    let session: MCSession  //複数のピア間の通信管理
    weak var delegate: SessionContainerDelegate?

    private let displayName: String
    private let advertiserAssistant: MCAdvertiserAssistant  //ピアを他のピアから存在を発見できるようにする（アドバタイズ）
        //接続要求に対する処理
    //<MCPeerID: 0x282d5f750 DisplayName = Yoshihisa>
//接続要求を受け取る準備
    init(displayName: String, serviceType: String) {
        self.displayName = displayName

        let peerID = MCPeerID(displayName: displayName)  //PeerID作成
        print(peerID)
        session = MCSession(peer: peerID) //複数のピア間の通信管理やるよ
        
        advertiserAssistant = MCAdvertiserAssistant(serviceType: serviceType,
                                                    discoveryInfo: nil,
                                                    session: session)
        //ピアを他のピアから存在を発見できるようにする（アドバタイズ）
        //接続要求に対する処理
        
        super.init()

        session.delegate = self //create session
        advertiserAssistant.start()  //ピアを他のピアから存在を発見できるように
    }

    deinit {
        advertiserAssistant.stop()
        session.disconnect()
    }
    

    func sendMessage(_ message: String) -> Transcript {
        let data = message.data(using: String.Encoding.utf8)
        try? session.send(data!, toPeers: session.connectedPeers, with: .reliable)
        //let transcript = Transcript(message: "test", peerID: session.myPeerID, direction: .send)
        let transcript = Transcript(message: message, peerID: session.myPeerID, direction: .send)
        return transcript
    }
    ////send sound 追加
    /*func sendSound(_ message: NSData){
        let data = message.data(using: String.Encoding.utf8)
        try? session.send(data!, toPeers: session.connectedPeers, with: .reliable)
    }*/
}

// MARK: - MCSessionDelegate


extension SessionContainer: MCSessionDelegate {

    // Remote peer changed state.
    // ピアの接続状態が変化すると
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print(#function)
        //guard state == .connected else { return }
        //guard let message = peerID else { return }
        //let transcript = Transcript(message: message, peerID: peerID, direction: .receive)
        //delegate?.sessionContainer(received: transcript)
    }

    // Received data from remote peer.
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print(#function)

        guard let message = String(data: data, encoding: .utf8) else { return }
        let transcript = Transcript(message: message, peerID: peerID, direction: .receive)
        delegate?.sessionContainer(received: transcript)
    }

    // Start receiving a resource from remote peer.
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print(#function)
    }

    // Finished receiving a resource from remote peer and saved the content
    // in a temporary location - the app is responsible for moving the file
    // to a permanent location within its sandbox.
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print(#function)
    }

    // Received a byte stream from remote peer.
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print(#function)
    }

    // Made first contact with peer and have identity information about the
    // remote peer (certificate may be nil).
    //    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Swift.Void) {
    //        print(#function)
    //        print(certificate)
    //    }

}
