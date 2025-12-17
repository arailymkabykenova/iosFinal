//
//  TopicViewController.swift
//  Word
//
//  Created by Арайлым Кабыкенова on 18.12.2025.
//
import UIKit
class TopicViewController:UIViewController,UIViewExtension{
    
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet var buttonView:[UIView]!
    @IBOutlet var buttonAppearance:[UIButton]!
    
    @IBAction func pressedTopicButton(_ sender: UIButton) {
        flow.category=sender.titleLabel?.text ?? "verbs"
        performSegue(withIdentifier: "category", sender: self)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let tabBarController = segue.destination as? UITabBarController {
//            // перебираем все контроллеры таб-бара
//            for navController in tabBarController.viewControllers ?? [] {
//                // проверяем, что это Navigation Controller
//                if let nav = navController as? UINavigationController {
//                    // теперь достаем главный контроллер из navigation stack
//                    if let mainVC = nav.viewControllers.first as? MainTabController {
//                        mainVC.flow = self.flow
//                    }
//                }
//            }
//        }
//    }

    
    var flow:WordFlow!
    override func viewDidLoad() {
        super.viewDidLoad()
        styleAllButtons(buttonAppearance)
        styleAllViews(buttonView)
    }
}

