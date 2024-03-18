//
//  GameScene.swift
//  Trial Shared
//
//  Created by Jiang, Yifan on 11/13/23.
//

// Assets for player sprite: https://game-endeavor.itch.io/mystic-woods

import SpriteKit
import Foundation



extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    fileprivate var label : SKLabelNode?
    
    struct PhysicsCategory {
        static let none: UInt32 = 0
        static let player: UInt32 = 0b1
        static let mailbox1: UInt32 = 0b10
        static let mailbox2: UInt32 = 0b11
        static let mailbox3: UInt32 = 0b100
        static let mailbox4: UInt32 = 0b101
    }
    
    var player: SKSpriteNode!
    var tileMap: SKTileMapNode!
    var cameraNode: SKCameraNode!
    var mailbox1: SKSpriteNode!
    var mailbox2: SKSpriteNode!
    var mailbox3: SKSpriteNode!
    var mailbox4: SKSpriteNode!
    var gamebackgroundMusic: SKAudioNode!
    var isMusicPlaying = true
    var currentSongIndex = 0
    let backgroundMusicFiles = ["Invasion", "mysterious garden", "space_echo"]
    
    func setUpPlayer(){
        let player = SKSpriteNode(imageNamed: "player")
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.mailbox1
        player.physicsBody?.contactTestBitMask = PhysicsCategory.mailbox2
        player.physicsBody?.contactTestBitMask = PhysicsCategory.mailbox3
        player.physicsBody?.contactTestBitMask = PhysicsCategory.mailbox4
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        player.physicsBody?.isDynamic = true
        self.player = player
    }
    
    func setUpMailbox1(){
        let mailbox1 = SKSpriteNode(imageNamed: "mailbox1")
        mailbox1.position = CGPoint(x: 350, y: 475)
        mailbox1.physicsBody = SKPhysicsBody(rectangleOf: mailbox1.size)
        mailbox1.physicsBody?.isDynamic = false
        mailbox1.physicsBody?.categoryBitMask = PhysicsCategory.mailbox1
        mailbox1.physicsBody?.contactTestBitMask = PhysicsCategory.player
        mailbox1.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.mailbox1 = mailbox1
        addChild(mailbox1)
    }
    
    func setUpMailbox2(){
        let mailbox2 = SKSpriteNode(imageNamed: "mailbox2")
        mailbox2.position = CGPoint(x: -350, y: 475)
        mailbox2.physicsBody = SKPhysicsBody(rectangleOf:mailbox2.size)
        mailbox2.physicsBody?.isDynamic = false
        mailbox2.physicsBody?.categoryBitMask = PhysicsCategory.mailbox2
        mailbox2.physicsBody?.contactTestBitMask = PhysicsCategory.player
        mailbox2.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.mailbox2 = mailbox2
        addChild(mailbox2)
    }
    
    func setUpMailbox3(){
        let mailbox3 = SKSpriteNode(imageNamed: "mailbox1")
        mailbox3.position = CGPoint(x: 350, y: -475)
        mailbox3.physicsBody = SKPhysicsBody(rectangleOf:mailbox3.size)
        mailbox3.physicsBody?.isDynamic = false
        mailbox3.physicsBody?.categoryBitMask = PhysicsCategory.mailbox3
        mailbox3.physicsBody?.contactTestBitMask = PhysicsCategory.player
        mailbox3.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.mailbox3 = mailbox3
        addChild(mailbox3)
    }
    
    func setUpMailbox4(){
        let mailbox4 = SKSpriteNode(imageNamed: "mailbox2")
        mailbox4.position = CGPoint(x: -350, y: -475)
        mailbox4.physicsBody = SKPhysicsBody(rectangleOf:mailbox4.size)
        mailbox4.physicsBody?.isDynamic = false
        mailbox4.physicsBody?.categoryBitMask = PhysicsCategory.mailbox4
        mailbox4.physicsBody?.contactTestBitMask = PhysicsCategory.player
        mailbox4.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.mailbox4 = mailbox4
        addChild(mailbox4)
    }
    
    
    class func newGameScene() -> GameScene {
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        return scene
    }
    
    func setUpScene() {
        self.physicsWorld.contactDelegate = self
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode)
    }
    
    func changeToMenuScene(){
        let nextScene = MenuScene(size: self.size)
        self.view?.presentScene(nextScene, transition: SKTransition.fade(withDuration: 1.0))
    }
    
    func changeToLogicScene(){
        let nextScene = LogicScene(size: self.size)
        self.view?.presentScene(nextScene, transition: SKTransition.fade(withDuration: 1.0))
    }
    
    func changeToCombinationScene() {
        let nextScene = CombinationScene(size: self.size)
        self.view?.presentScene(nextScene, transition: SKTransition.fade(withDuration: 1.0))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if (bodyA.categoryBitMask == PhysicsCategory.player && bodyB.categoryBitMask == PhysicsCategory.mailbox1) ||
            (bodyA.categoryBitMask == PhysicsCategory.mailbox1 && bodyB.categoryBitMask == PhysicsCategory.player) {
            print("Player has contacted mailbox 1")
            changeToMenuScene()
        }
        
        if (bodyA.categoryBitMask == PhysicsCategory.player && bodyB.categoryBitMask == PhysicsCategory.mailbox2) ||
            (bodyA.categoryBitMask == PhysicsCategory.mailbox2 && bodyB.categoryBitMask == PhysicsCategory.player) {
            print("Player has contacted the mailbox 2")
            changeToCombinationScene()
        }
        
        if (bodyA.categoryBitMask == PhysicsCategory.player && bodyB.categoryBitMask == PhysicsCategory.mailbox3) ||
            (bodyA.categoryBitMask == PhysicsCategory.mailbox3 && bodyB.categoryBitMask == PhysicsCategory.player) {
            print("Player has contacted the mailbox 3")
            changeToLogicScene()
        }
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
        self.setUpPlayer()
        self.setUpMailbox1()
        self.setUpMailbox2()
        self.setUpMailbox3()
        self.setUpMailbox4()
        mailbox1.setScale(2.5)
        mailbox2.setScale(2.5)
        mailbox3.setScale(2.5)
        mailbox4.setScale(2.5)
        player.zPosition = 100
        player.position = CGPoint(x: 0,y: 0)
        player.setScale(3)
        addChild(player)
        
        if let backgroundMusicFile = Bundle.main.url(forResource: backgroundMusicFiles[currentSongIndex], withExtension: "mp3") {
            print("File URL:", backgroundMusicFile)
            gamebackgroundMusic = SKAudioNode(url: backgroundMusicFile)
            addChild(gamebackgroundMusic)
            gamebackgroundMusic.run(SKAction.play())
        } else {
            print("Background music file not found.")
        }
        
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        cameraNode.position = player.position
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                movePlayer(to: touchLocation)
                toggleMusic()
            }
        }
        
        // Add this function to toggle music on and off
        func toggleMusic() {
            if isMusicPlaying {
                gamebackgroundMusic.run(SKAction.stop())
                isMusicPlaying = false
            } else {
                playRandomBackgroundMusic()
                isMusicPlaying = true
            }
        }
    
    
    func movePlayer(to position: CGPoint) {
        let moveAction = SKAction.move(to: position, duration: 0.5)
        player.run(moveAction)
    }
    
    

    
    func playRandomBackgroundMusic() {
        // Stop the current music
        gamebackgroundMusic.run(SKAction.stop())
        
        // Increment the current song index
        currentSongIndex = (currentSongIndex + 1) % backgroundMusicFiles.count
        
        // Load and play the next song
        if let nextSongFile = backgroundMusicFiles[safe: currentSongIndex],
           let nextSongURL = Bundle.main.url(forResource: nextSongFile, withExtension: "mp3") {
            gamebackgroundMusic = SKAudioNode(url: nextSongURL)
            addChild(gamebackgroundMusic)
            gamebackgroundMusic.run(SKAction.play())
            print("Playing background music:", nextSongFile)
        } else {
            print("Background music file not found.")
        }
        
        
        
    }
}
