//
//  ViewController.swift
//  FurnitureApp
//
//  Created by Rommel Rico on 5/28/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import MBProgressHUD

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    private var hud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hud = MBProgressHUD.showAdded(to: self.sceneView, animated: true)
        self.hud.label.text = "Detecting plane..."
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Register Gesture Recognizers
        registerGestureRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapped(recognizer: UITapGestureRecognizer) {
        if let sceneView = recognizer.view as? ARSCNView {
            let touch = recognizer.location(in: sceneView)
            let hitTestResults = sceneView.hitTest(touch, types: .existingPlane)
            if let hitTest = hitTestResults.first {
                // Get the model (i.e. the chair).
                
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            DispatchQueue.main.async {
                self.hud.label.text = "Plane detected!"
                self.hud.hide(animated: true, afterDelay: 1.0)
            }
        }
    }
    
}
