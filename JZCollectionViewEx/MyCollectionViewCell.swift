//
//  MyCollectionViewCell.swift
//  JZCollectionViewEx
//
//  Created by Jihong Zhang on 12/15/14.
//  Copyright (c) 2014 Jihong Zhang. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    let HorizontalSpacing : CGFloat = 5.0
    let VerticalSpacing : CGFloat = 5.0
    let lableHeight : CGFloat = 25
    
    var textLabel: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel = UILabel(frame: CGRectMake(0, frame.size.height-lableHeight-HorizontalSpacing*3, frame.size.width, lableHeight))
        textLabel.numberOfLines = 0
        //textLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        textLabel.textAlignment = .Center
        //contentView.addSubview(textLabel)  //this should be in top of the imageview, so add it after adding the imageview
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height ))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        //imageView.backgroundColor = UIColor.blueColor()
        contentView.addSubview(imageView)
        
        contentView.addSubview(textLabel)  //this should be in top of the imageview, so add it after adding the imageview
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
