//
//  VocablaryTabController.swift
//  Word
//
//  Created by Арайлым Кабыкенова on 18.12.2025.
//

import UIKit
class VocablaryViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var vocablaryTableView: UITableView!
  
    var checkedWords: [CheckedWord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vocablaryTableView.delegate = self
        vocablaryTableView.dataSource = self
        // vocablaryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        loadData()
    }
    
    func loadData() {
        checkedWords = Storage.shared.load()
        vocablaryTableView.reloadData()
    }
    
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkedWords.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = checkedWords[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CheckedCell else {
            return UITableViewCell()
        }
        
        
        cell.wordLabel.text = item.word
        cell.userAnswerLabel.text = item.userAnswer
        cell.viewImage.layer.cornerRadius = 20
        cell.viewImage.layer.masksToBounds = true
        
        if let imageName = item.imageName,
           let image = ImageStorage.shared.load(imageName: imageName) {
            cell.photoImageView.image = image
        } else {
            cell.photoImageView.image = UIImage(systemName: "photo")
        }
        
        return cell
    }
}
