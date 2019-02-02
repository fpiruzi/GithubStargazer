//
//  StargazerCell.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 02/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class StargazerCell: UITableViewCell{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    public func setTitle(value:String?){
        self.title.text = value ?? Constants.Strings.empty
    }
    
    public func setSubtitle(value:String?){
        self.subtitle.text = value ?? Constants.Strings.empty
    }
    
    public func setImageUrl(value:String?){
        self.profileImage.sd_setImage(
            with: URL(string: value ?? Constants.Strings.empty),
            placeholderImage: UIImage(named: Constants.Images.placeholder)
        )
    }
    
}
