//
//  ViewController.swift
//  GraphView
//
//  Created by Diego Costa on 22/11/18.
//  Copyright © 2018 Diego Costa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    private var firstView : GraphView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstView = GraphView(frame: CGRect(x: view.center.x - 30, y: 200, width: 60, height: 300))
        view.addSubview(firstView)
    }

}

