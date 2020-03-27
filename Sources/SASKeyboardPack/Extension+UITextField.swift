//
//  Extension+UITextField.swift
//  Admission App
//
//  Created by Anup Sukumaran on 07/02/19.
//  Copyright © 2019 Web India Solutions. All rights reserved.
//

import UIKit


extension UITextField {

    
   public class func connectFields(fields:[UITextField]) -> Void {
        
        guard let last = fields.last else { return }
        
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
    
    
    //MARK: IMPORTANT LINE - > Call the above function as shown in the viewDidLoad function  - > UITextField.connectFields(fields: [field1, field2, field3])
    
}


