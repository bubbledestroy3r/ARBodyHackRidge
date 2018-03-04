//
//  ViewController.swift
//  ARHealth
//
//  Created by Noah Cooper on 3/3/18.
//  Copyright © 2018 Alright Development. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var foodNum = 0
    var sceneText = SCNText()
    
    
    var scenes : [SCNScene] = [SCNScene(named: "art.scnassets/ship.scn")!, SCNScene(named: "art.scnassets/ship2.scn")!, SCNScene(named: "art.scnassets/ship3.scn")!, SCNScene(named: "art.scnassets/ship4.scn")!]
    var names : [String] = ["Orange", "Banana", "Carrot", "Chocolate Cake"]
    var colors : [UIColor] = [UIColor.black, UIColor.brown, UIColor.red, UIColor.blue]
    var messages : [String] = ["Oranges are a great way to start your day. They are great sources of Vitamin C and Fiber. Additionally, oranges stimulate digestive processes. 60 Calories per Orange.", "Bananas are a superfood that are perfect snack foods. They are great sources of Potassium. Plus, bananas can even help people with high blook pressure and even depression (and they go well with peanut butter)! 100 Calories per Banana", "Carrots are high in Fiber and Vitamin K. They are also high in antioxidants that help with vision while also protects you from heart disease and stroke. 25 Calories per Carrot", "Chocolate Cake is not very healthy! Only eat in moderation or when celebrating a big event! 400 Calories per piece of cake!"]
    
    
    override func viewDidLoad() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)))
        
        view.addGestureRecognizer(tap)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipe(_:)) )
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipe(_:)) )
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipe(_:)) )
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        
        view.addGestureRecognizer(swipeDown)
        
        sceneText.string = names[foodNum]
        sceneText.extrusionDepth = 1
        let textcolor = SCNMaterial()
        textcolor.diffuse.contents = UIColor.orange
        sceneText.materials = [textcolor]
        
        let textnode = SCNNode()
        textnode.position = SCNVector3(x: Float(0.082 + ((Double(foodNum))*(0.002))), y: 0.06, z: -0.6)
        textnode.scale = SCNVector3(x: 0.003, y: 0.003, z: 0.003)
        textnode.geometry = sceneText
       
        
        super.viewDidLoad()
        
        print(foodNum)
        
     
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        let scene = scenes[foodNum]
        
        // Set the scene to the view
        sceneView.scene = scene
        
        sceneView.scene.rootNode.addChildNode(textnode)
       
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer)
    {
        let alert = UIAlertController(title: names[foodNum], message: messages[foodNum], preferredStyle: .actionSheet)
        let close = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(close)
        self.present(alert, animated: true, completion: nil)
        print("tapped")
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer)
    {
        if(sender.direction == UISwipeGestureRecognizerDirection.left && foodNum < scenes.count - 1)
        {
            foodNum += 1
        }
        if(sender.direction == UISwipeGestureRecognizerDirection.right && foodNum > 0)
        {
            foodNum += -1
        }
        if(sender.direction == UISwipeGestureRecognizerDirection.down)
        {
            self.dismiss(animated: true, completion: nil)
        }
        print(foodNum)
        
        let scene = scenes[foodNum]
        sceneView.scene = scene
        changeText()
        
        
        
    }
    
    func changeText()
    {
        sceneText.string = names[foodNum]
        sceneText.extrusionDepth = 1
        let textcolor = SCNMaterial()
        textcolor.diffuse.contents = colors[foodNum]
        sceneText.materials = [textcolor]
        
        let textnode = SCNNode()
        textnode.position = SCNVector3(x: Float(0.082 + ((Double(foodNum))*(0.002))), y: 0.06, z: -0.6)
        textnode.scale = SCNVector3(x: 0.003, y: 0.003, z: 0.003)
        textnode.geometry = sceneText
        
        sceneView.scene.rootNode.addChildNode(textnode)
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
