//
//  ViewController.swift
//  AVCustomPickerViewFramework
//
//  Created by Harry on 5/27/16.
//  Copyright © 2016 Harry. All rights reserved.
//

import UIKit


class ViewController: UIViewController, PopUpPickerViewDelegate {
    
    var picker : PopUpPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClicked(sender: AnyObject) {
        picker = PopUpPickerView()
        picker.dataSource = ["1","2","3","4","5","6","7","8","9","10"]
        picker.delegate = self
        
        picker.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func pickerCancel() {
        
    }
    
    func pickerDone() {
        
    }
}

