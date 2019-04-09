//
//  QuestionController.swift
//  A la santé de
//
//  Created by Valentin on 05/04/2019.
//  Copyright © 2019 Valentin Garcia. All rights reserved.
//

import Foundation

class QuestionController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var toYou: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var passView: UIView!

    var selectedItemIndex: Int? = nil
    var lapPlayer = 1
    var isAnswerSelected = false
    
    override func viewDidLoad() {
        
        if #available(iOS 11.0, *) {
            if ((getAppdelegate()) != nil) {
                player.ry = player.ry + (getAppdelegate().window?.safeAreaInsets.top)!
                toYou.ry = player.ry + player.height + CGFloat(50)
                question.ry = toYou.ry + toYou.height + CGFloat(32)
                collectionView.ry = question.ry + question.height + CGFloat(50)
            }
        }
        collectionView.delegate = self
        
        if ((getAppdelegate()) != nil) {
            for i in 0..<getAppdelegate().listUserNames.count {
                lapPlayer += getAppdelegate().tabScore[i]
            }
            if(getAppdelegate().lapQuestion > getAppdelegate().listQuestions.count) {
                getAppdelegate().shuffleQuestions()
                getAppdelegate().lapQuestion = 1
            }
            player.text = getAppdelegate().listUserNames[lapPlayer-1].capitalized
            question.text = getAppdelegate().listQuestions[getAppdelegate().lapQuestion-1]
        }
        
        if(lapPlayer > 1) {
            passView.isHidden = true
        }
        
        collectionView.reloadData()
    }
    
    @IBAction func onClickPassQuestion(_ sender: Any) {
        
        getAppdelegate()?.lapQuestion+=1
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "questionView")
        self.navigationController!.pushViewController(vc, animated:true)
        self.navigationController?.viewControllers.remove(at: (navigationController?.viewControllers.firstIndex(of: self))!)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getAppdelegate()?.listUserNames.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! AnswerCell
        if(indexPath.item != selectedItemIndex) {
            cell.buttonImage.image = #imageLiteral(resourceName: "button_off.png")
        }
        else {
            cell.buttonImage.image = #imageLiteral(resourceName: "button_on.png")
        }
        cell.name.text = getAppdelegate()?.listUserNames[indexPath.item].uppercased()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItemIndex = indexPath.item
        collectionView.reloadData()
        
        if(!isAnswerSelected) {
            isAnswerSelected = true
            if(getAppdelegate() != nil) {
                getAppdelegate().tabScore[indexPath.item]+=1
            }
            if(lapPlayer < getAppdelegate().listUserNames.count) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "questionView")
                self.navigationController!.pushViewController(vc, animated:true)
                self.navigationController?.viewControllers.remove(at: (navigationController?.viewControllers.firstIndex(of: self))!)
            }
            else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "result")
                self.navigationController!.pushViewController(vc, animated:true)
                self.navigationController?.viewControllers.remove(at: (navigationController?.viewControllers.firstIndex(of: self))!)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if(isMovingFromParent) {
            getAppdelegate()?.cleanScore()
        }
    }

}
