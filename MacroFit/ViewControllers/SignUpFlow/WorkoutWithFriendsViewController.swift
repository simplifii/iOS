//
//  WorkoutWithFriendsViewController.swift
//  MacroFit
//
//  Created by Chandresh on 03/12/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import ContactsUI

class WorkoutWithFriendsViewController: BaseViewController {

    let contactStore = CNContactStore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func yesAction(_ sender: UIButton) {
        getPhoneBookContacts()
    }
    
    @IBAction func noThanksAction(_ sender: UIButton) {
        showNextScreen()
    }
    
    
    func getPhoneBookContacts() {
        var contacts: [[String:String]] = []
        
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        
        
        self.contactStore.requestAccess(for: .contacts, completionHandler: {(granted,error) in
            if (error != nil) {
                self.showAlertMessage(title: "Unable to access contacts", message: nil)
            }
            if granted {
                do {
                    try self.contactStore.enumerateContacts(with: request) {
                        (contact, stop) in
                        let phone = contact.phoneNumbers[0].value.stringValue
                        let email = "\(contact.emailAddresses[0].value)"
                        
                        if !phone.isEmpty || !email.isEmpty {
                            let userContact = [
                                "phone": phone,
                                "email": email
                            ]
                            contacts.append(userContact)
                        }
                    }
                    self.addContactsToUserNetwork(contacts: contacts)
                }
                catch {
                    self.showAlertMessage(title: "Unable to fetch contacts", message: nil)
                }
            }
        })
    }
    
    func addContactsToUserNetwork(contacts: [[String:String]]) {
        APIService.addContactsToUserNetwork(contacts: contacts, completion: {success,msg in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.showNextScreen()
            }
        })
    }
    
    func showNextScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
