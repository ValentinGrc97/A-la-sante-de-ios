//
//  LIstUsersController.swift
//  A la santé de
//
//  Created by Valentin on 04/04/2019.
//  Copyright © 2019 Valentin Garcia. All rights reserved.
//

import Foundation

class ListUsersController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var arrayTextField: [UITextField]!
    @IBOutlet var arrayFrameEditText: [UIView]!
    @IBOutlet weak var usersView: UIView!
    @IBOutlet weak var buttonAddUser: UIView!
    @IBOutlet weak var contentTextFieldView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var softView: UIView!
    @IBOutlet weak var hardView: UIView!
    
    override func viewDidLoad() {
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        usersView.layoutIfNeeded()
        usersView.layer.cornerRadius = 5
        usersView.layer.masksToBounds = true
        if #available(iOS 11.0, *) {
            usersView.ry = usersView.ry + (getAppdelegate().window?.safeAreaInsets.top)!
        }
        
        buttonAddUser.layoutIfNeeded()
        buttonAddUser.layer.cornerRadius = 5
        buttonAddUser.layer.masksToBounds = true
        
        for i in 0..<arrayTextField.count {
            arrayTextField[i].delegate = self
        }
        
        softView.ry = usersView.ry + usersView.height + CGFloat(40)
        softView.layoutIfNeeded()
        softView.layer.cornerRadius = 5
        softView.layer.masksToBounds = true
        
        hardView.ry = softView.ry + softView.height + CGFloat(30)
        hardView.layoutIfNeeded()
        hardView.layer.cornerRadius = 5
        hardView.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        for i in 0..<arrayTextField.count {
            if (textField != arrayTextField[i]) {
                arrayFrameEditText[i].backgroundColor = "000000".color()
            }
            else {
                arrayFrameEditText[i].backgroundColor = "FF4081".color()
                textField.tintColor = "FF4081".color()
            }
        }
        return true
    }

    @IBAction func onClickAddUser(_ sender: Any) {
        let newTextField = UITextField(frame: CGRect(x: (arrayTextField.last?.rx)!, y: (arrayTextField.last?.ry)! + (arrayTextField.last?.height)! + CGFloat(10), width: (arrayTextField.last?.width)!, height: (arrayTextField.last?.height)!))
        newTextField.attributedPlaceholder = NSAttributedString(string: "Joueur"+String(arrayTextField.count+1), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        newTextField.font = UIFont(name: "Courier", size: 18)
        newTextField.textColor = "FFFFFF".color()
        newTextField.delegate = self
        
        buttonAddUser.ry = newTextField.ry + newTextField.height + CGFloat(10)
        contentTextFieldView.addSubview(newTextField)
        contentTextFieldView.height = buttonAddUser.ry + buttonAddUser.height + CGFloat(10)
        arrayTextField.append(newTextField)
        
        let newFrameEditText = UIView(frame: CGRect(x: (arrayFrameEditText.last?.rx)!, y: (arrayTextField.last?.ry)! + (arrayTextField.last?.height)! - CGFloat(4), width: (arrayFrameEditText.last?.width)!, height: (arrayFrameEditText.last?.height)!))
        newFrameEditText.backgroundColor = "000000".color()
        contentTextFieldView.addSubview(newFrameEditText)
        arrayFrameEditText.append(newFrameEditText)
        
        scrollView.contentSize = self.contentTextFieldView.bounds.size
        scrollView.setContentOffset(CGPoint(x: 0, y: max(scrollView.contentSize.height - scrollView.bounds.size.height, 0) ), animated: true)
    }
    
    func selectedDifficulty() {
        getUsers()
        if(getAppdelegate().listUserNames.count >= 3) {
            getAppdelegate().shuffleQuestions()
            performSegue(withIdentifier: "question", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Pas assez de joueurs", message: "Ce jeu n'a aucun intérêt si vous n'êtes pas au moins 3 joueurs ! Faut arrêter l'alcool maintenant ...", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getUsers() {
        getAppdelegate().listUserNames.removeAll()
        for textField in arrayTextField {
            if(textField.text != "") {
                getAppdelegate().listUserNames.append(textField.text!)
                getAppdelegate().tabScore.append(0)
            }
        }
    }
    
    @IBAction func onClickSoftButton(_ sender: Any) {
        let preferences = UserDefaults.standard
        preferences.set("SOFT", forKey: "difficulty")
        preferences.synchronize()
        selectedDifficulty()
    }
    
    @IBAction func onClickHardButton(_ sender: Any) {
        let preferences = UserDefaults.standard
        preferences.set("HARD", forKey: "difficulty")
        preferences.synchronize()
        selectedDifficulty()
    }
}
