//
//  ClothItemViewCell.swift
//  Eazip
//
//  Created by Marie on 11/05/2019.
//  Copyright © 2019 Eazip. All rights reserved.
//

import UIKit

protocol ClothsPickingViewDelegate {
    func didIncreaseCountButtonPressed(cell: ClothItemViewCell)
    func didDecreaseCountButtonPressed(cell: ClothItemViewCell)
}

class ClothItemViewCell: UITableViewCell {
    var delegate : ClothsPickingViewDelegate?
    
    @IBOutlet weak var clothIcon: UIImageView!
    @IBOutlet weak var clothLabel: EazipLabel!
    @IBOutlet weak var countLabel: DefaultText!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var count : Int = 0
    var itemID : Int = 0
    var selectedState : Bool = false
    
    // Main Cell Colors
    let clothItemBackgroundColor : UIColor = UIColor(named: "backgroundLightGrey")!
    
    /**
     /////////////////////
     Up
     /////////////////////
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpWrapperView()
        updateCountLabel()
    }
    
    override func layoutSubviews() {
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCount()
    }
    
    func setUpWrapperView() {
        self.backgroundColor = clothItemBackgroundColor
        self.clothLabel?.font = FontHelper.eazipDefaultBlackFontWithSize(size: 17)
        self.countLabel?.font = FontHelper.eazipDefaultBlackFontWithSize(size: 17)
    }
    
    func setData(icon: UIImage, label: String, id: Int) {
        clothIcon.image = icon
        clothLabel.text = label
        itemID = id
    }
    
    @IBAction func addCloth(_ sender: UIButton) {
        delegate?.didIncreaseCountButtonPressed(cell: self)
    }
    
    @IBAction func removeCloth(_ sender: UIButton) {
        delegate?.didDecreaseCountButtonPressed(cell: self)
    }
    
    func addOne() {
        if count < 10 {
          count += 1
        }
        updateCountLabel()
    }
    
    func removeOne() {
        if count > 0 {
            count -= 1
        }
        updateCountLabel()
    }
    
    func resetCount() {
        count = 0
        updateCountLabel()
    }
    
    func updateCountLabel() {
        countLabel.text = String(describing: count)
        if count == 0 {
            countLabel.textColor = UIColor(named: "lightGrey")
        } else {
            countLabel.textColor = .black
        }
    }
    
    func getItemID() -> Int {
        return itemID
    }
    
    func getCount() -> Int {
        return count
    }
    
    func setCount(countNb: Int) -> Void {
        count = countNb
        updateCountLabel()
    }
    
    func tapAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundColor = UIColor(named: "lightPeachColor")
            self.backgroundColor = UIColor(named: "backgroundLightGrey")
        })
    }
}
