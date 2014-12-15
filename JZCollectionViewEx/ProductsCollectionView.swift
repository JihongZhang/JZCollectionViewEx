//
//  ProductsCollectionView.swift
//  JZScrollViewEx
//
//  Created by Jihong Zhang on 12/11/14.
//  Copyright (c) 2014 Jihong Zhang. All rights reserved.
//

import UIKit

class ProductsCollectionView : UICollectionViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private let footerCellName = "CategoryFooterViewIdentifier"
    private let headerCellName = "CategoryHeaderViewIdentifier"
    private let MyCollectionCellName = "MyCollectionCellIdentifier"
    private let headerSectionHeight : CGFloat = 50.0
    private var defaultCellSize : CGFloat = 0.0
    
    let HorizontalSpacing : CGFloat = 5.0
    let VerticalSpacing : CGFloat = 5.0

    
    var refreshControl = UIRefreshControl()
    
    
    //var collectionView: UICollectionView!
    var arrImages : [String]!
    
    var name : AnyObject? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey("name")
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "name")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
        
        let screenSize = UIScreen.mainScreen().bounds
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: VerticalSpacing, left: HorizontalSpacing, bottom: VerticalSpacing, right: HorizontalSpacing)
        layout.itemSize = CGSize(width: (screenSize.width-40)/2, height: (self.view.frame.height-160)/2 )   //4 cells
        self.collectionView!.collectionViewLayout = layout

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
/*
        let screenSize = UIScreen.mainScreen().bounds
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: VerticalSpacing, left: HorizontalSpacing, bottom: VerticalSpacing, right: HorizontalSpacing)
        layout.itemSize = CGSize(width: (screenSize.width-40)/2, height: (self.view.frame.height-160)/2 )   //4 cells
        self.collectionView!.collectionViewLayout = layout
*/
        /*
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        //collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collectionView!.backgroundColor = UIColor.whiteColor()  //.blueColor()   //.whiteColor()
        */
        setupView()
        
        //TODO: check if we have the similar images
        self.arrImages = ["YVE24841_1_enlarged.jpg", "img_dlp_dress1.png", "ANA20278_1_enlarged.jpg", "MAC20030_1_enlarged.jpg", "WDM20408_1_enlarged.jpg"];
        self.view.addSubview(collectionView!)
    }
    
    func setupView(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        /*
        let layout = UICollectionViewFlowLayout()
        defaultCellSize = (view.bounds.size.width - CGFloat(2.0)) / CGFloat(2.0)
        layout.itemSize = CGSize(width: defaultCellSize, height: defaultCellSize)
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
        layout.headerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height:headerSectionHeight)
        layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: 100.0)

        collectionView!.collectionViewLayout = layout
        */
        
        let titleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 60.0, height: 30.0))
        titleLabel.text = title
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        navigationItem.titleView = titleLabel
        
        collectionView!.registerClass(MyCollectionViewCell.classForCoder(), forCellWithReuseIdentifier:MyCollectionCellName)
        
        collectionView!.registerClass(MyCollectionViewCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerCellName)
        collectionView!.registerClass(MyCollectionViewCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellName)
        
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: "handleRefresh", forControlEvents: .ValueChanged)
        collectionView!.addSubview(refreshControl)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count // total number of cells
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MyCollectionCellName, forIndexPath: indexPath) as MyCollectionViewCell
        cell.textLabel?.text = "Text AAAAAAAA"
        cell.imageView.image = UIImage(named: self.arrImages![indexPath.row])
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        name = arrImages![indexPath.row]
        println("in didDeselectItemAtIndexPath: \(indexPath.row), name: \(name)")
    }
}
