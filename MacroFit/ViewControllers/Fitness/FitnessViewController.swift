//
//  FitnessViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 23/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
//import ContactsUI

class FitnessViewController: BaseViewController {
    @IBOutlet weak var navbarView: UIView!
    
//    let contactStore = CNContactStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
//    func getPhoneBookContacts() {
//        var contacts = [CNContact]()
//        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey]
//        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
//
//
//        self.contactStore.requestAccess(for: .contacts, completionHandler: {(granted,error) in
//            if (error != nil) {
//                print("access denied")
//            }
//            if granted {
//                do {
//                    try self.contactStore.enumerateContacts(with: request) {
//                        (contact, stop) in
//                        // Array containing all unified contacts from everywhere
//                        print(contact.phoneNumbers[0].value.stringValue)
//                        print(contact.emailAddresses[0].value)
//
//                        contacts.append(contact)
//                    }
//                }
//                catch {
//                    print("unable to fetch contacts")
//                }
//            }
//        })
//    }

}
