//
//  CellBooks.swift
//  Rus_dialog
//
//  Created by Игорь Дмитриев on 21.07.17.
//  Copyright © 2017 Игорь Дмитриев. All rights reserved.
//

import UIKit
import Foundation

public class CellBook : UITableViewCell
{
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblBookWriter: UILabel!
    @IBOutlet weak var lblBookCountShow: UILabel!
    @IBOutlet weak var gradientView: UIView!
	@IBOutlet weak var imgBookBackground: UIImageViewAsync!

	override public init(style: UITableViewCellStyle, reuseIdentifier: String?)
	{
		super.init(style: style, reuseIdentifier: reuseIdentifier)


	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		//fatalError("init(coder:) has not been implemented")
	}
    
    
}
