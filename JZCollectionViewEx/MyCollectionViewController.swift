//
//  MyCollectionViewController.swift
//  JZCollectionViewEx
//
//  Created by Jihong Zhang on 12/15/14.
//  Copyright (c) 2014 Jihong Zhang. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class MyCollectionViewController: UICollectionViewController {

    private let footerCellName = "CategoryFooterViewIdentifier"
    private let headerCellName = "CategoryHeaderViewIdentifier"
    private let MyCollectionCellName = "MyCollectionCellIdentifier"
    private let headerSectionHeight : CGFloat = 50.0
    private var defaultCellSize : CGFloat = 0.0
    
    let HorizontalSpacing : CGFloat = 5.0
    let VerticalSpacing : CGFloat = 5.0
    
    var arrImages : [String]!
    
    var refreshControl = UIRefreshControl()

    var name : AnyObject? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey("name")
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "name")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // Do any additional setup after loading the view.
        setupView()
        
        //TODO: check if we have the similar images
        self.arrImages = ["YVE24841_1_enlarged.jpg", "img_dlp_dress1.png", "ANA20278_1_enlarged.jpg", "MAC20030_1_enlarged.jpg", "WDM20408_1_enlarged.jpg"];
        
    }
    
    func setupView(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let layout = UICollectionViewFlowLayout()
        defaultCellSize = (view.bounds.size.width - CGFloat(2.0)) / CGFloat(2.0)
        layout.itemSize = CGSize(width: defaultCellSize, height: defaultCellSize)
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 20.0
        layout.headerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height:headerSectionHeight)
        layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: 100.0)
        
        collectionView!.collectionViewLayout = layout

        
        let titleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 60.0, height: 30.0))
        titleLabel.text = title
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        navigationItem.titleView = titleLabel
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView!.registerClass(MyCollectionViewCell.classForCoder(), forCellWithReuseIdentifier:MyCollectionCellName)
        
        collectionView!.registerClass(MyCollectionViewCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerCellName)
        collectionView!.registerClass(MyCollectionViewCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellName)
        collectionView!.backgroundColor = UIColor.whiteColor()
        
        
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: "handleRefresh", forControlEvents: .ValueChanged)
        collectionView!.addSubview(refreshControl)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func goToProductDetailPage() {
        NSLog("goToNextPage clicked");
        let svc = ProductDetailViewController()
        self.navigationController?.pushViewController(svc, animated: true);
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count // total number of cells
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MyCollectionCellName, forIndexPath: indexPath) as MyCollectionViewCell
        cell.textLabel?.text = "Text AAAAAAAA"
        //cell.imageView.image = UIImage(named: self.arrImages![indexPath.item])
        cell.imageView.image = UIImage(named: self.arrImages![indexPath.row])
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var row: Int = indexPath.row
        if(row >= arrImages.count){
            return
        }
        //name = arrImages![indexPath.item]
        name = arrImages![row]
        println("in didDeselectItemAtIndexPath:indexPath.item=\(indexPath.item)-row=\(indexPath.row),  row:\(row),  name: \(name)")
        
        goToProductDetailPage()
        
        /*
        var childVC = ProductVC(nibName : "ProductVC", bundle : nil)
        childVC.title = "Product"
        self.navigationController?.pushViewController(childVC, animated: false)
        */
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
