//
//  MenuScene.swift
//  Trial iOS
//
//  Created by Jiang, Yifan on 11/14/23.
//

import UIKit
import SpriteKit

class MenuScene: SKScene, SKPhysicsContactDelegate {
    private var label : SKLabelNode?
    
    struct PhysicsCategory {
        static let none: UInt32 = 0
        static let player: UInt32 = 0b1
        static let exitButton: UInt32 = 0b10
    }
    
    var player: SKSpriteNode!
    var exitButton: SKSpriteNode!
    
    func setUpPlayer(){
        let player = SKSpriteNode(imageNamed: "player")
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.exitButton
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        player.physicsBody?.isDynamic = true
        self.player = player
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
    
    func setUpUI(){
        let menu = SKSpriteNode(imageNamed: "menu")
        let id = SKSpriteNode(imageNamed: "id")
        menu.position = CGPoint(x: 295, y: 700)
        id.position = CGPoint(x: 400, y: 500)
        menu.setScale(2)
        id.setScale(2)
        addChild(menu)
        addChild(id)
    }
    
    func changeToGameScene(){
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
    }
    
//    override init(size: CGSize){
//        super.init(size:size)
//        backgroundColor = SKColor.green
//
//        let label = SKLabelNode(text: "You have picked up the special item")
//        label.position = CGPoint(x: size.width/2, y: size.height/2)
//        label.fontSize = 45
//        label.fontColor = SKColor.black
//        label.zPosition = 1
//        addChild(label)
//    }
//
//    required init?(coder aDecorder:NSCoder){
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if (bodyA.categoryBitMask == PhysicsCategory.player && bodyB.categoryBitMask == PhysicsCategory.exitButton) ||
            (bodyA.categoryBitMask == PhysicsCategory.exitButton && bodyB.categoryBitMask == PhysicsCategory.player) {
            print("Player has contacted exitButton")
            changeToGameScene()
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "rush-bg")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        self.setUpPlayer()
        self.setUpExitButton()
        self.setUpUI()
        player.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        player.zPosition = 100
        player.setScale(3)
        exitButton.setScale(9)
        background.setScale(1.7)
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
        // Called before each frame is rendered
        
    }
        
//    func movePlayer(to position: CGPoint) {
//
//    }

}
