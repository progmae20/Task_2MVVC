//
//  MainSignVC.swift
//  qwert
//
//  Created by Anastasiya on 16.11.21.
//

import UIKit

class MainSignVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailLError: UILabel!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordLError: UILabel!
    
    @IBOutlet weak var buttonUser: UIButton!

    private var users: [User] = []
    
    var isEmailValid = false
    var isPasswordValid = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLError.isHidden = true
        passwordLError.isHidden = true
        buttonUser.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func emailTFAction(_ sender: Any) {
        getUser()
    }
    
    @IBAction func passwordTFAction(_ sender: Any) {
        checkPassword()
    }
    
    @IBAction func buttonUserAction(_ sender: Any) {
        performSegue(withIdentifier: "goToAlbomVC", sender: users[0])
    }
    
    private func getUser() {
        
        guard let userEmail = emailTF.text else {
            
            return }
        let pathUrl = "\(ApiConstants.usersPath)?email=\(userEmail)"

        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.users = try JSONDecoder().decode([User].self, from: data)
                print(self.users)
                DispatchQueue.main.async {
                self.checkEmail2()
                }
            } catch let error {
                print(error)
            }
        }
        
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desination = segue.destination as? AlbumsVC,
            let user = sender as? User {
            desination.user = user
        }
    }

    private func checkEmail1() {
 
        let ifNil = emailTF.text != ""
        emailLError.isHidden = ifNil
        if ifNil {
            getUser()
        }
    }
    
    private func checkEmail2() {
 
        self.isEmailValid = !users.isEmpty
        emailLError.isHidden = self.isEmailValid
        updateStateBtn()
    }
    
    private func checkPassword() {
        
        self.isPasswordValid = passwordTF.text != ""
        passwordLError.isHidden = self.isPasswordValid
        updateStateBtn()
    }
    
    private func updateStateBtn() {
            buttonUser.isHidden = !(isEmailValid && isPasswordValid)
    }

}
