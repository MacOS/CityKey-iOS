//
//  SCCarouselSmallCollectionViewCell.swift
//  SmartCity
//
//  Created by Michael on 03.11.18.
//  Copyright © 2018 Michael. All rights reserved.
//

import UIKit
import Kingfisher

/**
 * @brief SCCarouselSmallCollectionViewCell should only be used
 * by the SCCarouselComponentViewController
 *
 * SCCarouselSmallCollectionViewCell is an tile for thre SCCarouselComponentViewController
 * Use the SCBaseComponentItem to set the content property of the tile.
 * The delgate is used by the SCCarouselComponentViewController to
 * get tap events.
 */
class SCCarouselSmallCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageBackView: UIView!
    @IBOutlet weak var interestTeaserLabel: UILabel!
    @IBOutlet weak var interestTitleLabel: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var ribbonImageView: UIImageView!
    @IBOutlet weak var ribbonLabel: UILabel!

    var tapGesture : UITapGestureRecognizer?

    weak var delegate : SCCarouselCollectionViewCellDelegate?
    
    var content: SCBaseComponentItem? {
        didSet {
            self.updateUI()
        }
    }
    
    private func showNewRibbon(_ show : Bool, color: UIColor){
        if !show {
            self.ribbonImageView.isHidden = true
            self.ribbonLabel.isHidden = true
        } else {
            self.ribbonImageView.isHidden = false
            self.ribbonLabel.isHidden = false
            
            let newImage = UIImage(named:"ribbon_top_left")!.maskWithColor(color: color)
            self.ribbonImageView.image = newImage
            self.ribbonLabel.text = "s_001_002_003_004_ribbon_label_new_item".localized()
            self.ribbonLabel.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 4));
        }
    }

    private func updateUI()
    {
        if let content = content {
            
            //adaptive Font Size
            interestTitleLabel.adaptFontSize()
            interestTeaserLabel.adaptFontSize()

            showNewRibbon(content.itemIsNew, color: content.itemColor)

            lockImageView.image = content.itemLockedDueAuth ? UIImage(named: "icon_locked_content") : content.itemLockedDueResidence  ? UIImage(named: "icon_limited_content") :  nil

            imageView.image = nil
            imageView.image = UIImage(named: content.itemImageURL!.absoluteUrlString())
            
            interestTitleLabel.text = content.itemTitle
            interestTeaserLabel.text = content.itemTeaser
            
            if (tapGesture == nil) {
                tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.teaserWasPressed))
                self.addGestureRecognizer(tapGesture!)
                
            }
       } else {
            imageView.image = nil
            interestTeaserLabel.text = nil
            tapGesture = nil
            lockImageView.image = nil
            showNewRibbon(false, color: .clear)
        }
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.layer.cornerRadius = 10.0
        self.interestTitleLabel.layer.cornerRadius = 10.0
        self.imageBackView.layer.shadowRadius = 3
        self.imageBackView.layer.shadowOpacity = 0.4
        self.imageBackView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        self.imageBackView.clipsToBounds = false
        self.interestTitleLabel.clipsToBounds = true
        self.imageView.clipsToBounds = true

    }
    
    @objc func teaserWasPressed() {
        if let item = content {
            self.delegate?.didSelectCarouselItem(item: item)
        }
    }
}
