//
//  ViewController.swift
//  Word
//
//  Created by Арайлым Кабыкенова on 17.12.2025.
//

import UIKit

class ViewController: UIViewController, UIViewExtension{
    @IBOutlet var buttonAppearance:[UIButton]!
    
    @IBOutlet var viewButtons:[UIView]!
    
    @IBAction func levelButton(_ sender: UIButton) {
        flow.level=sender.titleLabel?.text ?? "A1"
              
              self.performSegue(withIdentifier: "level", sender: self)
          }
          override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              let destinationVC=segue.destination as! TopicViewController
              destinationVC.flow=self.flow
          }
          var flow = WordFlow()
    override func viewDidLoad() {
        super.viewDidLoad()
        styleAllButtons(buttonAppearance)
        styleAllViews(viewButtons)
        // Do any additional setup after loading the view.
        
    }


}

