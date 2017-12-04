//
//  GameScene.swift
//  Commotion
//
//  Created by Eric Larson on 9/6/16.
//  Copyright © 2016 Eric Larson. All rights reserved.
//
import UIKit
import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let BoiCategory : UInt32 = 0x1 << 0
    let AppleCategory : UInt32 = 0x1 << 1
    
    // MARK: Raw Motion Functions
    let motion = CMMotionManager()
    
    let score = SKLabelNode(fontNamed: "Chalkduster")
    var scoreNum = 0
    
    let highScore = SKLabelNode(fontNamed: "Chalkduster")
    var highScoreNum = 0
    
    func startMotionUpdates(){
        // some internal inconsistency here: we need to ask the device manager for device
        
        if self.motion.isDeviceMotionAvailable{
            self.motion.deviceMotionUpdateInterval = 0.1
            self.motion.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: self.handleMotion )
        }
    }
    
    func handleMotion(_ motionData:CMDeviceMotion?, error:Error?){
        if let gravity = motionData?.gravity {
            self.physicsWorld.gravity = CGVector(dx: CGFloat(19.8*gravity.x), dy: CGFloat(19.8*gravity.y))
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == BoiCategory && secondBody.categoryBitMask == AppleCategory {
            let sprite1 = self.childNode(withName: "apple")
            sprite1?.removeFromParent()
            self.addApple()
            scoreNum += 1
            score.text = "Score: " + String(scoreNum)
            
            if (scoreNum > highScoreNum)
            {
                highScoreNum = scoreNum
                highScore.text = "Record: " + String(scoreNum)
                UserDefaults.standard.set(self.highScoreNum, forKey: "highScore")
            }
            
        }
    }
    
    // MARK: View Hierarchy Functions
    override func didMove(to view: SKView) {
        
        if let newHighScore = UserDefaults.standard.object(forKey: "highScore") as? Int {
            self.highScoreNum = newHighScore
            self.highScore.text = "Record: " + String(self.highScoreNum)
        } else {
            UserDefaults.standard.set(0, forKey: "highScore")
        }
    
        // Set up background image\
        let background = SKSpriteNode(imageNamed: "background_leaf.jpg")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = -1
        addChild(background)
        
        // start motion for gravity
        self.startMotionUpdates()
        
        // make sides to the screen
        self.addGameBoundaries()
        
        // Add boi
        self.addBoi()
        
        // Add two walls
        self.addObstacle(CGPoint(x: size.width/2, y: size.height * 0.30))
        self.addObstacle(CGPoint(x: size.width/2, y: size.height * 0.70))
        
        // Add spinner in the middle
        self.addSpinningObstacle(CGPoint(x: size.width/2, y: size.height/2))
        
        // Add fidget spinners
        self.addSpinner(CGPoint(x: size.width/5, y: size.height * 0.35))
        self.addSpinner(CGPoint(x: size.width/4, y: size.height * 0.75))
        self.addSpinner(CGPoint(x: size.width/1.2, y: size.height * 0.4))
        self.addSpinner(CGPoint(x: size.width/1, y: size.height * 0.75))
        self.addSpinner(CGPoint(x: size.width/2, y: size.height * 0.3))
        
        // Add goal
        self.addApple()
        
        score.text = "Score: " + String(scoreNum)
        score.fontSize = 25
        score.fontColor = SKColor.init(red: 0.03529, green: 0.868, blue: 0.086, alpha: 1.0)
        score.position = CGPoint(x: size.width * 0.72, y: size.height * 0.045)
        
//        highScore.text = "Record: " + String(scoreNum)
        highScore.fontSize = 25
        highScore.fontColor = SKColor.init(red: 0.03529, green: 0.868, blue: 0.086, alpha: 1.0)
        highScore.position = CGPoint(x: size.width * 0.28, y: size.height * 0.045)
        
        
        addChild(score)
        addChild(highScore)
        
        
        self.physicsWorld.contactDelegate = self
    }
    
    
    // MARK: Create Sprites Functions
    func addBoi(){
        
        let boi = SKSpriteNode(imageNamed: "kellen.png")
        
        boi.size = CGSize(width:size.width*0.13,height:size.height * 0.11492169)
        
        boi.position = CGPoint(x: size.width/2, y: size.height * 0.18)
        
        boi.physicsBody = SKPhysicsBody(rectangleOf:boi.size)
        //boi.physicsBody?.restitution = random(min: CGFloat(1.0), max: CGFloat(1.5))
        boi.physicsBody?.restitution = 0.15
        
        boi.physicsBody?.isDynamic = true
        boi.zPosition = 1
        
        // For collision uses
        boi.name = "boi"
        boi.physicsBody?.categoryBitMask = BoiCategory
        boi.physicsBody?.contactTestBitMask = AppleCategory
        //boi.physicsBody?.collisionBitMask = AppleCategory
        
        
        self.addChild(boi)
    }
    
    func addApple(){
        
        let apple = SKSpriteNode(imageNamed: "apple")
        
        apple.size = CGSize(width:size.width*0.11,height:size.height * 0.07)
        
        var apple_locations: [CGPoint] = [CGPoint(x: size.width/2, y: size.height * 0.8),
                                          CGPoint(x: size.width/2, y: size.height * 0.2),
                                          CGPoint(x: size.width * 0.33, y: size.height * 0.5),
                                          CGPoint(x: size.width * 0.66, y: size.height * 0.5),
                                          CGPoint(x: size.width * 0.33, y: size.height * 0.8),
                                          CGPoint(x: size.width * 0.66, y: size.height * 0.8),
                                          CGPoint(x: size.width * 0.33, y: size.height * 0.2),
                                          CGPoint(x: size.width * 0.66, y: size.height * 0.2)]
        
        
        let r = arc4random_uniform(7)
        
        apple.position = apple_locations[Int(r)]
        
        apple.physicsBody = SKPhysicsBody(rectangleOf:apple.size)
        //boi.physicsBody?.restitution = random(min: CGFloat(1.0), max: CGFloat(1.5))
        apple.physicsBody?.restitution = 0
        
        apple.physicsBody?.isDynamic = true
        apple.zPosition = 1
        
        apple.name = "apple"
        apple.physicsBody?.categoryBitMask = AppleCategory
        apple.physicsBody?.contactTestBitMask = BoiCategory
        
        self.addChild(apple)
        
    }
    
    func addObstacle(_ point:CGPoint){
        
        let wall = SKSpriteNode(imageNamed: "wall.jpg")
        
        wall.size = CGSize(width:size.width*0.4,height: size.height * 0.04 )
        
        wall.position = point
        
        wall.physicsBody = SKPhysicsBody(rectangleOf:wall.size)
        wall.physicsBody?.restitution = 1
        
        wall.physicsBody?.isDynamic = false
        
        self.addChild(wall)
        
    }
    
    func addSpinningObstacle(_ point:CGPoint){
        
        let wall = SKSpriteNode(imageNamed: "spinner2")
        
        wall.size = CGSize(width:size.width*0.16,height: size.height * 0.09)
        
        wall.position = point
        
        wall.physicsBody = SKPhysicsBody(circleOfRadius: wall.size.width/2)
        wall.physicsBody?.restitution = 1.1
        
        wall.physicsBody?.isDynamic = true
        wall.physicsBody?.allowsRotation = true
        wall.physicsBody?.pinned = true
        
        wall.zPosition = 1
        
        self.addChild(wall)
        
        
    }
    
    func addSpinner(_ point:CGPoint){
        
        let boi = SKSpriteNode(imageNamed: "spinner")
        
        boi.size = CGSize(width:size.width*0.16,height:size.height * 0.09)
        
        boi.position = point
        
        boi.physicsBody = SKPhysicsBody(circleOfRadius: boi.size.width/2)
        //boi.physicsBody?.restitution = random(min: CGFloat(1.0), max: CGFloat(1.5))
        boi.physicsBody?.restitution = 0.15
        
        boi.physicsBody?.isDynamic = true
        boi.zPosition = 1
        
        self.addChild(boi)
    }
    
    
    
    func addGameBoundaries(){
        let left = SKSpriteNode()
        let right = SKSpriteNode()
        let top = SKSpriteNode()
        let bottom = SKSpriteNode()
        
        left.size = CGSize(width:size.width*0.1,height:size.height)
        left.position = CGPoint(x:0, y:size.height*0.5)
        
        right.size = CGSize(width:size.width*0.1,height:size.height)
        right.position = CGPoint(x:size.width, y:size.height*0.5)
        
        top.size = CGSize(width:size.width,height:size.height*0.1)
        top.position = CGPoint(x:size.width*0.5, y:size.height*0.95)
        
        bottom.size = CGSize(width:size.width,height:size.height*0.1)
        bottom.position = CGPoint(x:size.width*0.5, y:size.height*0.05)
        
        for obj in [left,right,top,bottom]{
            obj.color = UIColor.brown
            obj.physicsBody = SKPhysicsBody(rectangleOf:obj.size)
            obj.physicsBody?.isDynamic = true
            obj.physicsBody?.pinned = true
            obj.physicsBody?.allowsRotation = false
            self.addChild(obj)
        }
        
        
    }
    //
    //    // MARK: UI Delegate Functions
    //    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        self.addApple()
    //    }
    //
    // MARK: Utility Functions (thanks ray wenderlich!)
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}
