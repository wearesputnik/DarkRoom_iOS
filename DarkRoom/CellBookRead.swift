//
//  CellBookRead.swift
//  Rus_dialog
//
//  Created by Игорь Дмитриев on 28.07.17.
//  Copyright © 2017 Игорь Дмитриев. All rights reserved.
//

import UIKit
import Foundation

public class CellBookRead: UITableViewCell
{
	@IBOutlet weak var lblMessage: UILabel!
	@IBOutlet weak var lblUser: UILabel!
	@IBOutlet weak var backgroundViewMessage: UIView!

	override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}


	

}




