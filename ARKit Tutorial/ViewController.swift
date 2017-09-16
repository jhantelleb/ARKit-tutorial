//
//  ViewController.swift
//  ARKit Tutorial
//
//  Created by Jhantelle Belleza on 9/16/17.
//  Copyright © 2017 JhantelleB. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBAction func addCube(_ sender: Any) {
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        
        let cc = getCameraCoordinates(sceneView: sceneView)
        cubeNode.position = SCNVector3(cc.x, cc.y, cc.z) //expressed in meters with 20cms
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    @IBAction func addCup(_ sender: Any) {
        let cubeNode = SCNNode()
        
        let cc = getCameraCoordinates(sceneView: sceneView)
        cubeNode.position = SCNVector3(cc.x, cc.y, cc.z) //expressed in meters with 20cms
        
        guard let virtualObjectScene = SCNScene(named: "cup.scn", inDirectory: "Models.scnassets/cup") else { return }
        
        //MARK: Nodes - a virtual object contains many nodes, we're adding all nodes to the scene
        
        let wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        cubeNode.addChildNode(wrapperNode)
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
    private func getCameraCoordinates(sceneView: ARSCNView) -> CameraCoordinates {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!) //Tells you where an object is in 3D space
        
        var cc = CameraCoordinates()
        cc.z = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.x = cameraCoordinates.translation.x
        
        return cc
    }
    
}

//How Nodes Work:
//Rootnode - (x,y,z) (0,0,0)
//If we add cube node 1, it gets placed as a child of root node (10, 0, 0)
//2nd cube will be places on (-10, 0, 0)
//3rd node, cup node (0, -10, 0)
//Spoon node (child of cup would be placed (0,0,0) same coordinates of the parent node

