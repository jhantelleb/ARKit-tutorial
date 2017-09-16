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
        let zcoordinate = randomFloat(min: -2, max: -0.2)
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        cubeNode.position = SCNVector3(0, 0, zcoordinate) //expressed in meters with 20cms
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
 
    @IBAction func addCup(_ sender: Any) {
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

