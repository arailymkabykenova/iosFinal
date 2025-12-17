//
//  SynonymAnswerViewController.swift
//  Word
//
//  Created by Арайлым Кабыкенова on 18.12.2025.
//

import UIKit
class SynonymAnswerViewController:UIViewController,UIViewExtension{
    func updateUI(_ object: UIView) {
        if let button = object as? UIButton {
            button.layer.cornerRadius = 8
            button.clipsToBounds = true
            button.titleLabel?.font = UIFont(name: "STIXTwoText-Bold", size: 20)
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
        }
    }
    
    func styleAllButtons(_ buttons: [UIButton]) {
        buttons.forEach { updateUI($0) }
    }
    @IBOutlet var labelImageViews:[UIView]!
    @IBOutlet weak var wordMainLabel:UILabel!
    @IBOutlet weak var synonymLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet var buttonAppearance:[UIButton]!
    @IBAction func addPhotoButton(_ sender: Any) {
    }
    
    @IBAction func safeButton(_ sender: Any) {
    }
    var netManager:NetworkManager!
    @IBOutlet weak var photoViewImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        netManager.delegate2=self
        styleAllButtons(buttonAppearance)
        styleAllViews(labelImageViews)
    }
}
extension SynonymAnswerViewController:SynonymCheckManager{
    func didCheckSynonym(_ synonymCheckManager: NetworkManager, _ recievedData: AnswerCheckData) {
        print(recievedData.data.correct)
        synonymLabel.text=recievedData.data.userAnswer
        wordMainLabel.text=recievedData.data.word
        if recievedData.data.correct{
            checkLabel.text="RIGHT"
            photoViewImage.image=UIImage(named: "win")
        }else{
            checkLabel.text="FALSE"
            photoViewImage.image=UIImage(named: "sad")
        }
    }
}
