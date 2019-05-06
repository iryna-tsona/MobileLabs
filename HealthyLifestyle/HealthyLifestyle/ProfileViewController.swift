//
//  ProfileViewController.swift
//  HealthyLifestyle
//
//  Created by Ірина Цьона on 3/25/19.
//  Copyright © 2019 Ірина Цьона. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.lineWidth = 20
            shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
            let color = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).cgColor
            shapeLayer.strokeColor = color
        }
    }
    
    override func viewDidLayoutSubviews() {
        configShapeLayer(shapeLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("sign out error: \(error.localizedDescription)")
        }
    }
   
    func configShapeLayer(_ shapeLayer: CAShapeLayer) {
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2))
        path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 2))
        path.move(to: CGPoint(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2))
        path.addLine(to: CGPoint(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2 - 200))
        path.move(to: CGPoint(x: self.view.frame.width / 2 + 70, y: self.view.frame.height / 2))
        path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 70, y: self.view.frame.height / 2 - 200))
        path.move(to: CGPoint(x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 2))
        path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 2 + 30))
        shapeLayer.path = path.cgPath
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
