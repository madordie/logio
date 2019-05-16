//
//  ViewController.swift
//  logio
//
//  Created by madordie on 05/15/2019.
//  Copyright (c) 2019 madordie. All rights reserved.
//

import UIKit
import logio
import CocoaLumberjack

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DDLog.add(LogIO.shared)
        LogIO.shared.content(host: "10.12.12.10", port: 28777)
        DDLogInfo("VC加载成功")
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func action(_ sender: Any) {
        DDLogInfo("\(Date().timeIntervalSince1970)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

