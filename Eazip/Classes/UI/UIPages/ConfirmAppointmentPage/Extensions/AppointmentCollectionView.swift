//
//  AppointmentCollectionView.swift
//  Eazip
//
//  Created by Marie on 18/04/2019.
//  Copyright © 2019 Eazip. All rights reserved.
//
import UIKit

extension ConfirmAppointmentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection: Int) -> Int {
        return appointmentSections
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth : CGFloat = 0
       
        if indexPath.row == 3 {
            cellWidth = UIScreen.main.bounds.size.width
        } else {
            cellWidth = UIScreen.main.bounds.size.width-30
        }
        
        return CGSize(width: cellWidth, height:200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = ConfirmScreenTemplate(data: appointment)
        let itemsInView = viewModel.templateWithData()
        let item = itemsInView[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item).reuseId, for: indexPath)
        item.configure(cell: cell)
        
        return cell
    }
}