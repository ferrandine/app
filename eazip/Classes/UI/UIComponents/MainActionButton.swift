//
//  MainActionButton.swift
//  Eazip
//
//  Created by Marie on 26/01/2019.
//  Copyright © 2019 Eazip. All rights reserved.
//

import UIKit

class MainActionButton: EazipButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override func prepareForInterfaceBuilder() {
        setUp()
    }
    
    override func setUp() {
        self.backgroundColor = UIColor(named: "eazipDarkBlue")
        self.setTitleColor(.white, for: .normal)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = 25
        self.layer.shadowOffset = CGSize.zero
    }
}

