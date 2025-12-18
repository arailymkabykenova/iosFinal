//
//  MainTabController.swift
//  Word
//
//  Created by Арайлым Кабыкенова on 18.12.2025.
//

import Lottie
import UIKit
class MainTabController:UIViewController,UIViewExtension{
    var loadingAnimationView: LottieAnimationView?
    func updateUI(_ object: UIView) {
        object.backgroundColor = .systemYellow
        object.layer.cornerRadius = 8
        object.clipsToBounds = true
        
        if let button = object as? UIButton {
            button.layer.cornerRadius = 8
            button.clipsToBounds = true
            button.titleLabel?.font = UIFont(name: "STIXTwoText-Bold", size: 20)
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
        }
    }
    
    func styleAllButtons(_ buttons: [UIButton]) {
        buttons.forEach { updateUI($0) }
    }
    
    func styleAllViews(_ views: [UIView]) {
        views.forEach { updateUI($0) }
    }
    @IBOutlet var views:[UIView]!
    @IBOutlet weak var imageTop: UIImageView!
    @IBOutlet weak var topicTextsField: UITextField!
    @IBOutlet var buttonsAppeareance:[UIButton]!
    @IBOutlet weak var generateButton:UIButton!
    @IBOutlet weak var checkButton:UIButton!
    @IBOutlet weak var synonymTextField: UITextField!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    
    @IBAction func generateButton(_ sender: UIButton) {
        flow.theme=topicTextsField.text ?? "english"
        guard let level=flow.level , let category = flow.category , let theme = flow.theme else{
            return
        }
        let request=SendData(level: level, category: category, theme: theme)
        showLoadingAnimation()
        netManager.fetchData(endpoint: .getWord, requestData: request)
    }
    
    
    @IBAction func checkButton(_ sender: UIButton) {
        guard let word = wordLabel.text,let userAnswer=synonymTextField.text else{return}
         let synonym=SynonymData(word: word, userAnswer: userAnswer)
         netManager.fetchData(endpoint:.check, requestData:synonym)
         performSegue(withIdentifier: "synonym", sender: self)
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let destinationVC=segue.destination as? SynonymAnswerViewController else{return}
         destinationVC.netManager=self.netManager
     }
        var flow:WordFlow!
        let netManager=NetworkManager()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            generateButton.isEnabled = false
               checkButton.isEnabled = false

               topicTextsField.addTarget(self,
                                         action: #selector(textFieldDidChange),
                                         for: .editingChanged)

               synonymTextField.addTarget(self,
                                          action: #selector(textFieldDidChange),
                                          for: .editingChanged)
            netManager.delegate=self
            topicTextsField.delegate=self
            synonymTextField.delegate=self
            styleAllButtons(buttonsAppeareance)
            styleAllViews(views)
            
        }
    @objc func textFieldDidChange() {
        let isTopicFilled = !(topicTextsField.text?.isEmpty ?? true)
        let isSynonymFilled = !(synonymTextField.text?.isEmpty ?? true)

        generateButton.isEnabled = isTopicFilled
        checkButton.isEnabled = isSynonymFilled
    }
    }
    extension MainTabController:UITextFieldDelegate{
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            return true
        }
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != ""{
                return true
            }else{
                if textField==topicTextsField{
                    textField.placeholder="Enter the topic"
                    if textField==synonymTextField{
                        textField.placeholder="Enter the synonym"
                    }
                }
            }
            return false
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            print(textField.text ?? "нет ничего")
      
        }
    }

extension MainTabController:WordManagerDelegate{
    func didUpdateWord(
        _ wordManager: NetworkManager,
        _ recievedData: RecievedData
    ) {
        wordLabel.text = recievedData.data.text
        meaningLabel.text = recievedData.data.meaning
        exampleLabel.text=recievedData.data.examples[0]
    }
    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    func didCheckSynonym() {
        hideLoadingAnimation() 
        synonymTextField.text = ""
        checkButton.isEnabled = false
    }
}

extension MainTabController{
    func showLoadingAnimation() {
        loadingAnimationView?.removeFromSuperview()
    
        loadingAnimationView = LottieAnimationView(name: "Cooking Preloader")
        guard let loadingAnimationView else { return }

        loadingAnimationView.contentMode = .scaleAspectFit
        loadingAnimationView.loopMode = .loop

        view.addSubview(loadingAnimationView)

        loadingAnimationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        loadingAnimationView.center = view.center

        loadingAnimationView.play()
    }

    func hideLoadingAnimation() {
        loadingAnimationView?.stop()
        loadingAnimationView?.removeFromSuperview()
    }
}
