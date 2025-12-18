//
//  SynonymAnswerViewController.swift
//  Word
//
//  Created by Арайлым Кабыкенова on 18.12.2025.
//

import UIKit
import Lottie
class SynonymAnswerViewController:UIViewController,UIViewExtension{
    var loadingAnimationView: LottieAnimationView?


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
        let picker=UIImagePickerController()
        picker.delegate=self
        picker.sourceType = .photoLibrary
        picker.allowsEditing=true
        present(picker, animated: true)
    }
    var wordText: String = ""
    var userAnswerText: String = ""
    @IBAction func safeButton(_ sender: Any) {
        var imageName: String? = nil
        
        if let image = photoViewImage.image {
            imageName = ImageStorage.shared.save(image: image)
        }
        
        let newItem = CheckedWord(
            word: wordMainLabel.text ?? "",
            userAnswer: synonymLabel.text ?? "",
            imageName: imageName
        )
        
        var savedItems = Storage.shared.load()
        savedItems.append(newItem)
        Storage.shared.save(savedItems)
        dismiss(animated: true)
        //navigationController?.popViewController(animated: true)
    }
    
    
    var netManager:NetworkManager!
    @IBOutlet weak var photoViewImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        wordMainLabel.text = wordText
        synonymLabel.text = userAnswerText
        showLoadingAnimation()
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
            hideLoadingAnimation()
            checkLabel.text="RIGHT"
            photoViewImage.image=UIImage(named: "win")
        }else{
            hideLoadingAnimation()
            checkLabel.text="FALSE"
            photoViewImage.image=UIImage(named: "sad")
        }
    }
}
extension SynonymAnswerViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            photoViewImage.image = image
        }
        picker.dismiss(animated: true)
    }
}
extension SynonymAnswerViewController{
    func showLoadingAnimation(){
        loadingAnimationView?.removeFromSuperview()
            loadingAnimationView = LottieAnimationView(name: "Cats for new year and christmas")
            guard let loadingAnimationView else { return }

            loadingAnimationView.contentMode = .scaleAspectFit
            loadingAnimationView.loopMode = .loop

            view.addSubview(loadingAnimationView)

            // Через frame
            loadingAnimationView.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            loadingAnimationView.center = view.center

            loadingAnimationView.play()
    }
    func hideLoadingAnimation() {
        loadingAnimationView?.stop()
        loadingAnimationView?.removeFromSuperview()
    }
}
