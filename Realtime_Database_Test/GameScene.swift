//
//  GameScene.swift
//  Realtime_Database_Test
//
//  Created by Da Lin on 10/31/18.
//  Copyright © 2018 Da Lin. All rights reserved.
//

import SpriteKit
import GameplayKit
import Firebase

class GameScene: SKScene {
    
    let currentPlayer = 2
    
    //Test1
    
    let rootRef = Database.database().reference()
    let ballRefX = Database.database().reference().child("ball").child("position").child("x");
    let ballRefY = Database.database().reference().child("ball").child("position").child("y");
    let p1Refx = Database.database().reference().child("player1").child("position").child("x");
    let p1Refy = Database.database().reference().child("player1").child("position").child("y");
    let p2Refx = Database.database().reference().child("player2").child("position").child("x");
    let p2Refy = Database.database().reference().child("player2").child("position").child("y");
    
    var ball = SKSpriteNode()
    var player1 = SKSpriteNode()
    var player2 = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        player1 = self.childNode(withName: "player1") as! SKSpriteNode
        player2 = self.childNode(withName: "player2") as! SKSpriteNode
        
        if currentPlayer == 1{
            ball.physicsBody?.applyImpulse(CGVector(dx:30, dy:30))
        }
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        ballRefX.observe(DataEventType.value) { (snapshot) in
            let p1PosX = snapshot.value as? String
            if let posX = p1PosX{
                if self.currentPlayer != 1{
                    self.ball.run(SKAction.moveTo(x: CGFloat(truncating: NumberFormatter().number(from: posX)!), duration: 0.002))
                }
            }
        }
        ballRefY.observe(DataEventType.value) { (snapshot) in
            let p1PosX = snapshot.value as? String
            if let posX = p1PosX{
                if self.currentPlayer != 1{
                    self.ball.run(SKAction.moveTo(y: CGFloat(truncating: NumberFormatter().number(from: posX)!), duration: 0.002))
                }
            }
        }
        p1Refx.observe(DataEventType.value) { (snapshot) in
            let p1PosX = snapshot.value as? String
            if let posX = p1PosX{
                if self.currentPlayer != 1{
                    self.player1.run(SKAction.moveTo(x: CGFloat(truncating: NumberFormatter().number(from: posX)!), duration: 0.002))
                }
            }
        }
        p2Refx.observe(DataEventType.value) { (snapshot) in
            let p2PosX = snapshot.value as? String
            if let posX = p2PosX{
                if self.currentPlayer != 2{
                    self.player2.run(SKAction.moveTo(x: CGFloat(truncating: NumberFormatter().number(from: posX)!), duration: 0.002))
                }
            }
        }

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for t in touches {
            let location = t.location(in: self)
            if currentPlayer == 1{
                player1.run(SKAction.moveTo(x: location.x, duration: 0.2))
                p1Refx.setValue("\(player1.position.x)")
            }else if currentPlayer == 2{
                player2.run(SKAction.moveTo(x: location.x, duration: 0.2))
                p2Refx.setValue("\(player2.position.x)")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            if currentPlayer == 1{
                player1.run(SKAction.moveTo(x: location.x, duration: 0.2))
                p1Refx.setValue("\(player1.position.x)")
            }else if currentPlayer == 2{
                player2.run(SKAction.moveTo(x: location.x, duration: 0.2))
                p2Refx.setValue("\(player2.position.x)")
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(currentPlayer == 1){
            ballRefX.setValue("\(ball.position.x)")
            ballRefY.setValue("\(ball.position.y)")
        }
    }
}
