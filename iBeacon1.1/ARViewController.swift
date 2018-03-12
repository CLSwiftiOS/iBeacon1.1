//
//  ARViewController.swift
//  iBeacon1.1
//
//  Created by Christian Liefeldt on 07.12.17.
//  Copyright © 2017 CL. All rights reserved.
//
import ARKit
import SceneKit
import UIKit

class ARViewController: UIViewController {
    
    var Zone = 0 as Int
    
    @IBAction func btnBack(_ sender: Any) {
    }

    
    override func viewDidLoad() {
        switch Zone {
        case 0: print("keine Zone übergeben / noch 0")
        case 1:
            let text = SCNText(string: " Info Zone 1\n hier könnten wichtige\n Informatioen stehen", extrusionDepth: 2)
            let TextProperty = SCNMaterial()
            TextProperty.diffuse.contents = UIColor.green
            text.materials = [TextProperty]
            let TextNode = SCNNode()
            TextNode.position = SCNVector3(-0.4,0.0,-1.3)
            TextNode.scale = SCNVector3(0.01,0.01,0.01)
            TextNode.geometry = text
            sceneView.scene.rootNode.addChildNode(TextNode)
        case 2:
            let text = SCNText(string: " Info Zone 2\n hier könnten wichtige\n Informatioen stehen", extrusionDepth: 2)
            let TextProperty = SCNMaterial()
            TextProperty.diffuse.contents = UIColor.green
            text.materials = [TextProperty]
            let TextNode = SCNNode()
            TextNode.position = SCNVector3(-0.4,0.0,-1.3)
            TextNode.scale = SCNVector3(0.01,0.01,0.01)
            TextNode.geometry = text
            sceneView.scene.rootNode.addChildNode(TextNode)
        case 3:
            let text = SCNText(string: " Info Zone 3\n hier könnten wichtige\n Informatioen stehen", extrusionDepth: 2)
            let TextProperty = SCNMaterial()
            TextProperty.diffuse.contents = UIColor.green
            text.materials = [TextProperty]
            let TextNode = SCNNode()
            TextNode.position = SCNVector3(-0.4,0.0,-1.3)
            TextNode.scale = SCNVector3(0.01,0.01,0.01)
            TextNode.geometry = text
            sceneView.scene.rootNode.addChildNode(TextNode)
        case 4:
            let text = SCNText(string: " Info Zone 4\n hier könnten wichtige\n Informatioen stehen", extrusionDepth: 2)
            let TextProperty = SCNMaterial()
            TextProperty.diffuse.contents = UIColor.green
            text.materials = [TextProperty]
            let TextNode = SCNNode()
            TextNode.position = SCNVector3(-0.4,0.0,-1.3)
            TextNode.scale = SCNVector3(0.01,0.01,0.01)
            TextNode.geometry = text
            sceneView.scene.rootNode.addChildNode(TextNode)
        default: print("keine Zone übergeben")
        }
        
        super.viewDidLoad()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
    }
    
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    @IBOutlet weak var sceneView: ARSCNView!
    
    struct myCameraCoordinates{
        var x = Float()
        var y = Float()
        var z = Float()
    }
    
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
        
        let cameraCoordinates = MDLTransform()
        
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        
        return cc
        
    }
}

