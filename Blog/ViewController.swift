//
//  ViewController.swift
//  Blog
//
//  Created by Vuk on 7/13/16.
//  Copyright © 2016 User. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var prikazBloga: UIWebView!
    var preuzmi: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            prikazBloga.loadHTMLString(preuzmi!, baseURL: URL(string: "http://georgetteoden.blogspot.rs"))
            prikazBloga.contentMode = UIViewContentMode.scaleAspectFill
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

