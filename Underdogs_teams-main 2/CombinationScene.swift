//
//  CombinationScene.swift
//  Trial iOS
//
//  Created by Jiang, Yifan on 11/15/23.
//

import SpriteKit

class CombinationScene: SKScene {
    var enteredCombination = ""
    let targetCombination = "214"
    var combinationDisplay: SKLabelNode!
    
    var zero: SKSpriteNode?
    var one: SKSpriteNode?
    var two: SKSpriteNode?
    var three: SKSpriteNode?
    var four: SKSpriteNode?
    var five: SKSpriteNode?
    var six: SKSpriteNode?
    var seven: SKSpriteNode?
    var eight: SKSpriteNode?
    var nine: SKSpriteNode?
    

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "rush-bg")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1
        background.setScale(1.7)
        self.setupUI()
        self.setupDigits()
        addChild(background)
    }

    func setupUI() {
        // Set up the display label for the entered combination
        combinationDisplay = SKLabelNode(fontNamed: "Courier-Bold")
        combinationDisplay.fontSize = 150
        combinationDisplay.fontColor = SKColor.black
        combinationDisplay.position = CGPoint(x: frame.midX, y: frame.midY + 100)
       
        addChild(combinationDisplay)

        // Set up number buttons
        for i in 0...9 {
            let numberNode = SKLabelNode(fontNamed: "Arial")
            numberNode.name = "number_\(i)"
            numberNode.text = "\(i)"
            numberNode.fontSize = 100
            numberNode.fontColor = SKColor.clear
            numberNode.isHidden = false
            numberNode.position = CGPoint(x: (frame.midX + CGFloat(i - 5) * 100 + 40), y: frame.midY)
            addChild(numberNode)
        }
    }

//    func setupUI() {
//        // Set up the display label for the entered combination
//        combinationDisplay = SKLabelNode(fontNamed: "Arial")
//        combinationDisplay.fontSize = 40
//        combinationDisplay.fontColor = SKColor.black
//        combinationDisplay.position = CGPoint(x: frame.midX, y: frame.midY + 100)
//        addChild(combinationDisplay)
//
//        // Set up number buttons as SKSpriteNodes
//        let numbers = [one, two, three, four, five, six, seven, eight, nine]
//        for (index, number) in numbers.enumerated() {
//            if let numberNode = number {
//                numberNode.name = "number_\(index + 1)"
//                numberNode.position = CGPoint(x: frame.midX + CGFloat(index - 4) * 60, y: frame.midY)
//                addChild(numberNode)
//            }
//        }
//    }

    func setupZero(){
        let zero = SKSpriteNode(imageNamed: "zero")
        zero.position = CGPoint(x: 223, y: 550)
        zero.setScale(2.5)
        self.zero = zero
        addChild(zero)
    }
    
    func setupOne(){
        let one = SKSpriteNode(imageNamed: "one")
        one.position = CGPoint(x: 323, y: 550)
        one.setScale(2.5)
        self.one = one
        addChild(one)
    }
    
    func setupTwo(){
        let two = SKSpriteNode(imageNamed: "two")
        two.position = CGPoint(x: 423, y: 550)
        two.setScale(2.5)
        self.two = two
        addChild(two)
    }
    
    func setupThree(){
        let three = SKSpriteNode(imageNamed: "three")
        three.position = CGPoint(x: 523, y: 550)
        three.setScale(2.5)
        self.three = three
        addChild(three)
    }
    
    func setupFour(){
        let four = SKSpriteNode(imageNamed: "four")
        four.position = CGPoint(x: 623, y: 550)
        four.setScale(2.5)
        self.four = four
        addChild(four)
    }
    
    func setupFive(){
        let five = SKSpriteNode(imageNamed: "five")
        five.position = CGPoint(x: 723, y: 550)
        five.setScale(2.5)
        self.five = five
        addChild(five)
    }
    
    func setupSix(){
        let six = SKSpriteNode(imageNamed: "six")
        six.position = CGPoint(x: 823, y: 550)
        six.setScale(2.5)
        self.six = six
        addChild(six)
    }
    
    func setupSeven(){
        let seven = SKSpriteNode(imageNamed: "seven")
        seven.position = CGPoint(x: 923, y: 550)
        seven.setScale(2.5)
        self.seven = seven
        addChild(seven)
    }
    
    func setupEight(){
        let eight = SKSpriteNode(imageNamed: "eight")
        eight.position = CGPoint(x: 1023, y: 550)
        eight.setScale(2.5)
        self.eight = eight
        addChild(eight)
    }
    
    func setupNine(){
        let nine = SKSpriteNode(imageNamed: "nine")
        nine.position = CGPoint(x: 1123, y: 550)
        nine.setScale(2.5)
        self.nine = nine
        addChild(nine)
    }
    
    func setupDigits(){
        setupZero(); setupOne(); setupTwo(); setupThree(); setupFour(); setupFive(); setupSix(); setupSeven(); setupEight(); setupNine();
    }
    
    func handleNumberInput(_ number: Int) {
        enteredCombination += String(number)
        combinationDisplay.text = enteredCombination
        checkCombination()
    }
    
    func changeToGameScene(){
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
    }

    func checkCombination() {
        if enteredCombination == targetCombination {
            print("Correct Combination!")
            // Handle correct combination
            combinationDisplay.text = "Correct!"
            changeToGameScene()
        } else if enteredCombination.count >= targetCombination.count {
            print("Incorrect Combination. Try again.")
            resetCombination()
        }
    }

    func resetCombination() {
        enteredCombination = ""
        combinationDisplay.text = enteredCombination
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name, nodeName.starts(with: "number_"), let numberString = nodeName.split(separator: "_").last, let number = Int(numberString) {
                handleNumberInput(number)
            }
        }
    }
}
