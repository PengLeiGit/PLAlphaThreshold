//
//  ViewController.swift
//  PLAlphaThreshold
//
//  Created by 1248667206@qq.com on 07/16/2020.
//  Copyright (c) 2020 1248667206@qq.com. All rights reserved.
//

import UIKit
import PLAlphaThreshold

class ViewController: UIViewController {
    
    lazy var btn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var popV: PLAlphaThresholdView = {
        let view = PLAlphaThresholdView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(btn)
        btn.frame = CGRect(x: 40, y: 10, width: 60, height: 60)
        
        view.addSubview(popV)
        popV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        view.addGestureRecognizer(tap)
    }

    @objc func btnClick() {
        print("瞅你咋地--页面按钮")
    }
    
    @objc func tapClick() {
        print("再瞅一个试试--页面")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

