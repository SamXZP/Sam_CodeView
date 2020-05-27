//
//  ViewController.swift
//  Sam_CodeView
//
//  Created by gztzxzp@163.com on 05/27/2020.
//  Copyright (c) 2020 gztzxzp@163.com. All rights reserved.
//

import UIKit
import Sam_CodeView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = CodeView.init(frame: CGRect.init(x: 30, y: 160, width: UIScreen.main.bounds.width-60, height: 50), codeNumber: 6, style: .CodeStyle_line)
        view.codeBlock = { [weak self] code in
            print("\n\n=======>您输入的验证码是：\(code)")
        }
        self.view.addSubview(view)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

