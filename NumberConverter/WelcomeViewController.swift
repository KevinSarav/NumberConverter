//
//  ViewController.swift
//  NumberConverter
//
//  Created by Saravia, Kevin on 7/2/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // This view is for the welcome screen.
    // Welcome screen includes labels, an image and a button to segue into the Converter view.
    
    @IBOutlet weak var imgNumbers: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgNumbers.image = UIImage(named: "numbers.jpg")
    }

}

