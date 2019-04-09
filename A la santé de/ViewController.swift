//
//  ViewController.swift
//  A la santé de
//
//  Created by Valentin on 03/04/2019.
//  Copyright © 2019 Valentin Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var background_rectangle: UIView!
    @IBOutlet weak var label_presentation: UILabel!
    @IBOutlet weak var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background_rectangle.height = label_presentation.height + CGFloat(8)
        background_rectangle.layoutIfNeeded()
        background_rectangle.layer.cornerRadius = 5
        background_rectangle.layer.masksToBounds = true
    
        
        buttonView.layoutIfNeeded()
        buttonView.layer.cornerRadius = 5
        buttonView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

