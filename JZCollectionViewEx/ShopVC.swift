//
//  ShopVC.swift
//  SwiftNetwork
//
//  Created by Radu Leca on 12/5/14.
//  Copyright (c) 2014 Radu Leca. All rights reserved.
//

import UIKit
import Alamofire

class ShopVC: UICollectionViewController, DataDelegate {
    
    private let footerCellName = "CategoryFooterViewIdentifier"
    private let headerCellName = "CategoryHeaderViewIdentifier"
    private let categoryCellName = "CategoryCellIdentifier"
    private let headerSectionHeight : CGFloat = 50.0
    
    private var defaultCellSize : CGFloat = 0.0
    
    var refreshControl = UIRefreshControl()
    var isDetail = false
    
    let itemPerSection = 4
    var tileList : [Tile]

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        tileList = []
        super.init(nibName : nibNameOrNil, bundle : nibBundleOrNil)
        title = "Shopping"
    }
    
    required init(coder aDecoder: NSCoder) {
        tileList = []
        super.init(coder: aDecoder)
        title = "Shopping"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !self.isDetail {
            NetworkEngine.GetGrid(dataDelegate : self)
        }

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.collectionView?.reloadData()
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if (tileList.count % itemPerSection) == 0 {
            return tileList.count / itemPerSection }
        else {
            return tileList.count / itemPerSection + 1
        }
    }
        
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let remain = tileList.count - section * itemPerSection
        if remain < 0 {
            return 0 }
        if remain > itemPerSection {
            return itemPerSection
        }
        
        return remain
    }
    
    private func indexPathToIndex(indexPath: NSIndexPath) -> Int {
        return indexPath.row + indexPath.section * itemPerSection
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(categoryCellName, forIndexPath: indexPath) as CategoryCollectionViewCell
        
        let urlIndex = indexPathToIndex(indexPath)
        if var imageURL = tileList[urlIndex].url {
            imageURL += "?width=\(defaultCellSize)"
        
            cell.imageView.image = nil
            cell.request = Alamofire.request(.GET, imageURL).responseImage() {
                (request, _, image, error) in
                if error == nil && image != nil {
                    if request.URLString == cell.request?.request.URLString {
                        cell.imageView.image = image
                        }
                }
            }
        }
        
        return cell
    }
    
/*    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        var reusableView : UICollectionReusableView? = nil
        switch kind
        {
            case UICollectionElementKindSectionHeader:
                reusableView = collectionView.dequeueReusableCellWithReuseIdentifier(headerCellName, forIndexPath: indexPath) as? UICollectionReusableView
                (reusableView as CategoryCollectionViewHeaderCell).text = "Cucu"
                (reusableView as CategoryCollectionViewHeaderCell).refresh()
            
            default:
                reusableView = collectionView.dequeueReusableCellWithReuseIdentifier(footerCellName, forIndexPath: indexPath) as? UICollectionReusableView
        }
        
        return reusableView!
    }  */
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSizeMake(200, headerSectionHeight)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let index = indexPathToIndex(indexPath)
        var tile = tileList[index]
        
        if tile is Web
        {
            var alertMsg = UIAlertView(title: "", message: "Select a ceros", delegate:nil, cancelButtonTitle:"OK")
            alertMsg.show()
        } else {
        
            if !isDetail
            {
                var childVC = ShopVC(nibName : "ShopVC", bundle : nil)
                childVC.tileList = DataManager.sales()
                childVC.title = tile.title
                childVC.isDetail = true
                self.navigationController?.pushViewController(childVC, animated: true)
            } else
            {
                var childVC = ProductVC(nibName : "ProductVC", bundle : nil)
                childVC.title = "Product"
                self.navigationController?.pushViewController(childVC, animated: false)
            }
        }
    }

    func setupView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let layout = UICollectionViewFlowLayout()
        defaultCellSize = (view.bounds.size.width - CGFloat(2.0)) / CGFloat(2.0)
        layout.itemSize = CGSize(width: defaultCellSize, height: defaultCellSize)
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
        layout.headerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height:headerSectionHeight)
        layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: 100.0)
        
        collectionView!.collectionViewLayout = layout
        
        let titleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 60.0, height: 30.0))
        titleLabel.text = title
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        navigationItem.titleView = titleLabel
        
        collectionView!.registerClass(CategoryCollectionViewCell.classForCoder(), forCellWithReuseIdentifier:categoryCellName)
        
        collectionView!.registerClass(CategoryCollectionViewLoadingCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerCellName)
        collectionView!.registerClass(CategoryCollectionViewHeaderCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellName)
        
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: "handleRefresh", forControlEvents: .ValueChanged)
        collectionView!.addSubview(refreshControl)
    }
    
    func handleRefresh() {
    }
    
    func onSucced()
    {
        if DS.sharedInstance.gridList.count() >= 1
        {
            var grid = DS.sharedInstance.gridList.objectList[0] as Grid
            self.tileList = grid.tilesList
            
            self.collectionView?.reloadData()
        }
    }
    
    func OnFailed()
    {
    }
}

class CategoryCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    var request: Alamofire.Request?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        
        imageView.frame = bounds
        addSubview(imageView)
    }
}

class CategoryCollectionViewLoadingCell: UICollectionReusableView {
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        spinner.startAnimating()
        spinner.center = self.center
        addSubview(spinner)
    }
}

class CategoryCollectionViewHeaderCell: UICollectionReusableView {
    let label = UILabel(frame: CGRectMake(10, 10, 200, 50))
    var text : String = ""
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blueColor()
        label.text = text
        addSubview(label)
    }
    
    func refresh()
    {
        self.layer.setNeedsDisplay()
    }
}
