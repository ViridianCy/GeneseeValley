//
//  LogicScene.swift
//  Trial iOS
//
//  Created by Jiang, Yifan on 11/15/23.
//

import Foundation
import SpriteKit

class LogicScene: SKScene, SKPhysicsContactDelegate {
    struct PhysicsCategory {
        static let none: UInt32 = 0
        static let player: UInt32 = 0b1
        static let node1: UInt32 = 0b10
        static let node2: UInt32 = 0b11
        static let node3: UInt32 = 0b100
        static let node4: UInt32 = 0b101
        static let node5: UInt32 = 0b110
        static let exitButton: UInt32 = 0b111
        static let light1: UInt32 = 0b1000
        static let light2: UInt32 = 0b1001
        static let light3: UInt32 = 0b1010
        static let light4: UInt32 = 0b1011
        static let light5: UInt32 = 0b1100
    }
    
    var player: SKSpriteNode!
    var tileMap: SKTileMapNode!
    var exitButton: SKSpriteNode!
    var node1: SKSpriteNode!
    var node2: SKSpriteNode!
    var node3: SKSpriteNode!
    var node4: SKSpriteNode!
    var node5: SKSpriteNode!
    var light1: SKSpriteNode!
    var light2: SKSpriteNode!
    var light3: SKSpriteNode!
    var light4: SKSpriteNode!
    var light5: SKSpriteNode!
    var node1Value: Bool = false
    var node2Value: Bool = false
    var node3Value: Bool = false
    var node4Value: Bool = false
    let rectangleSize = CGSize(width: 115, height: 120)
    
    func setUpPlayer(){
        let player = SKSpriteNode(imageNamed: "player")
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.node1
        player.physicsBody?.contactTestBitMask = PhysicsCategory.node2
        player.physicsBody?.contactTestBitMask = PhysicsCategory.node3
        player.physicsBody?.contactTestBitMask = PhysicsCategory.node4
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        player.physicsBody?.isDynamic = true
        self.player = player
    }
    
    func setUpNode1(){
//        let offsetY: CGFloat = 1
        let node1 = SKSpriteNode(color: .orange, size: rectangleSize)
        node1.position = CGPoint(x: 400, y: 840)
        node1.physicsBody = SKPhysicsBody(rectangleOf: node1.size)
        node1.physicsBody?.isDynamic = false
        node1.physicsBody?.categoryBitMask = PhysicsCategory.node1
        node1.physicsBody?.contactTestBitMask = PhysicsCategory.player
        node1.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.node1 = node1
        addChild(node1)
    }
    
    func setUpNode2(){
        let node2 = SKSpriteNode(color: .orange, size: rectangleSize)
        node2.position = CGPoint(x: 400, y: 650)
        node2.physicsBody = SKPhysicsBody(rectangleOf:node2.size)
        node2.physicsBody?.isDynamic = false
        node2.physicsBody?.categoryBitMask = PhysicsCategory.node2
        node2.physicsBody?.contactTestBitMask = PhysicsCategory.player
        node2.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.node2 = node2
        addChild(node2)
    }
    
    func setUpNode3(){
        let node3 = SKSpriteNode(color: .orange, size: rectangleSize)
        node3.position = CGPoint(x: 400, y: 400)
        node3.physicsBody = SKPhysicsBody(rectangleOf:node3.size)
        node3.physicsBody?.isDynamic = false
        node3.physicsBody?.categoryBitMask = PhysicsCategory.node3
        node3.physicsBody?.contactTestBitMask = PhysicsCategory.player
        node3.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.node3 = node3
        addChild(node3)
    }
    
    func setUpNode4(){
        let node4 = SKSpriteNode(color: .orange, size: rectangleSize)
        node4.position = CGPoint(x: 175, y: 220)
        node4.physicsBody = SKPhysicsBody(rectangleOf:node4.size)
        node4.physicsBody?.isDynamic = false
        node4.physicsBody?.categoryBitMask = PhysicsCategory.node4
        node4.physicsBody?.contactTestBitMask = PhysicsCategory.player
        node4.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.node4 = node4
        addChild(node4)
    }
    
    func setUpNode5(){
        let node5 = SKSpriteNode(color: .orange, size: rectangleSize)
        node5.position = CGPoint(x: 1180, y: 540)
        node5.physicsBody = SKPhysicsBody(rectangleOf:node4.size)
        node5.physicsBody?.isDynamic = false
        node5.physicsBody?.categoryBitMask = PhysicsCategory.node5
        node5.physicsBody?.contactTestBitMask = PhysicsCategory.player
        node5.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.node5 = node5
        addChild(node5)
    }
    
    func setUpExitButton(){
        let exitButton = SKSpriteNode(imageNamed: "exitButton")
        exitButton.position = CGPoint(x: 1200, y: 900)
        exitButton.physicsBody = SKPhysicsBody(rectangleOf: exitButton.size)
        exitButton.physicsBody?.isDynamic = false
        exitButton.physicsBody?.categoryBitMask = PhysicsCategory.exitButton
        exitButton.physicsBody?.contactTestBitMask = PhysicsCategory.player
        exitButton.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.exitButton = exitButton
        addChild(exitButton)
    }
    
    func checkSolved() {
        let isSolved: Bool = ((node1Value != node2Value) && (node3Value && !node4Value))
        if (isSolved) {
            light5.isHidden = false
            changeToGameScene()
        }
    }
    
    func changeToGameSceneExit(){
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
    }
    
    func changeToGameScene(){
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 5.0))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if (bodyA.categoryBitMask == PhysicsCategory.player && bodyB.categoryBitMask == PhysicsCategory.exitButton) ||
            (bodyA.categoryBitMask == PhysicsCategory.exitButton && bodyB.categoryBitMask == PhysicsCategory.player) {
            print("Player has contacted exitButton")
            changeToGameSceneExit()
        }
        
        if (bodyA.categoryBitMask == PhysicsCategory.player && bodyB.categoryBitMask == PhysicsCategory.node1) ||
            (bodyA.categoryBitMask == PhysicsCategory.node1 && bodyB.categoryBitMask == PhysicsCategory.player) {
            print("Player has contacted node 1")
            node1Value = !node1Value
            light1.isHidden = !node1Value
            checkSolved()
        }
        
        if (bodyA.categoryBitMask == PhysicsCategory.player && bodyB.categoryBitMask == PhysicsCategory.node2) ||
            (bodyA.categoryBitMask == PhysicsCategory.node2 && bodyB.categoryBitMask == PhysicsCategory.player) {
            print("Player has contacted node 2")
            node2Value = !node2Value
            light2.isHidden = !node2Value
            checkSolved()
        }
        
        if (bodyA.categoryBitMask == PhysicsCategory.player && bodyB.categoryBitMask == PhysicsCategory.node3) ||
            (bodyA.categoryBitMask == PhysicsCategory.node3 && bodyB.categoryBitMask == PhysicsCategory.player) {
            print("Player has contacted node 3")
            node3Value = !node3Value
            light3.isHidden = !node3Value
            checkSolved()
        }
        
        if (bodyA.categoryBitMask == PhysicsCategory.player && bodyB.categoryBitMask == PhysicsCategory.node4) ||
            (bodyA.categoryBitMask == PhysicsCategory.node4 && bodyB.categoryBitMask == PhysicsCategory.player) {
            print("Player has contacted node 4")
            node4Value = !node4Value
            light4.isHidden = !node4Value
            checkSolved()
        }
    }
    

    func addGreenRectangleUnderNode(node: SKSpriteNode) -> SKSpriteNode {
        let rectangleSize = CGSize(width: 130, height: 130)

        let rectangle = SKSpriteNode(color: .green, size: rectangleSize)
        rectangle.position = CGPoint(x: node.position.x, y: node.position.y)
        //rectangle.zPosition = node.zPosition - 1
        rectangle.isHidden = true
        addChild(rectangle)
        return rectangle
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "circuit")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        self.setUpPlayer()
        self.setUpExitButton()
        
        //self.setUpScene()
    
        self.setUpNode1()
        self.setUpNode2()
        self.setUpNode3()
        self.setUpNode4()
        self.setUpNode5()

        light1 = addGreenRectangleUnderNode(node: node1)
        light2 = addGreenRectangleUnderNode(node: node2)
        light3 = addGreenRectangleUnderNode(node: node3)
        light4 = addGreenRectangleUnderNode(node: node4)
        light5 = addGreenRectangleUnderNode(node: node5)
        
        player.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        player.zPosition = 100
        player.setScale(3)
        
        exitButton.setScale(9)
        background.setScale(2.5)
        addChild(player)
        addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
                movePlayer(to: touchLocation)
        }
    }
    
    func movePlayer(to position: CGPoint) {
        let moveAction = SKAction.move(to: position, duration: 0.5)
        player.run(moveAction)
    }

    override func update(_ currentTime: TimeInterval) {

    }

    
}
