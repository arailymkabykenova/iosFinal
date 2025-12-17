//
//  ViewController.swift
//  Word
//
//  Created by Арайлым Кабыкенова on 17.12.2025.
//

import UIKit
protocol UpdateButtonsDelegate {
    func updateButtons()
}
class ViewController: UIViewController {
    @IBOutlet var buttonAppearance:[UIButton]!
    
    @IBOutlet var viewButtons:[UIView]!
    
    @IBAction func levelButton(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

