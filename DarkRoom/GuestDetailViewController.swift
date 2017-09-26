//
//  GuestDetailViewController.swift
//  Rus_dialog
//
//  Created by Игорь Дмитриев on 27.07.17.
//  Copyright © 2017 Игорь Дмитриев. All rights reserved.
//

import UIKit
import Foundation

public class GuestDetailViewController : UIViewController
{
	@IBOutlet weak var imgBookBackground: UIImageViewAsync!
	@IBOutlet weak var lblBookDescribtion: UILabel!
	@IBOutlet weak var lblBookAuthor: UILabel!
	@IBOutlet weak var lblBookName: UILabel!
	@IBOutlet weak var lblBookCountShow: UILabel!
	@IBOutlet weak var lblCountAuthorRating: UILabel!
	@IBOutlet weak var gradientView: UIView!

	var imgBackground:UIImage?

	var book:Dictionary<String, AnyObject> = [:]

	override public func viewDidLoad() {
        super.viewDidLoad()

		ConnectServer.GetBooks(id: 0 ){books in
			if books != nil
			{
				self.book = books
				if self.book != nil
				{
					DispatchQueue.main.async {
						self.lblBookDescribtion.text = self.book["description"] as? String
						self.lblBookCountShow.text = self.book["is_view_count"] as? String
						self.lblBookName.text = self.book["name"] as? String
						self.lblBookAuthor.text = self.book["author"] as? String
						self.lblCountAuthorRating.text = self.book["raiting"] as? String
						if self.book["path_cover_file"] != nil
						{
							self.imgBookBackground.downloadImage(url: ConnectServer.URL_IMAGE + (((self.book["path_cover_file"])!) as! String) as! String)
						}
					}

				}

			}

		}

		if self.book != nil
		{
			self.lblBookDescribtion.text = self.book["description"] as? String
			self.lblBookCountShow.text = self.book["is_view_count"] as? String
			self.lblBookName.text = self.book["name"] as? String
			self.lblBookAuthor.text = self.book["author"] as? String
			self.lblCountAuthorRating.text = self.book["raiting"] as? String

		}

		if self.imgBookBackground != nil
		{
			self.imgBookBackground.image = self.imgBackground
		}



		let gradient = CAGradientLayer()
        gradient.frame = (self.gradientView.bounds)
        gradient.colors = [UIColor.clear.cgColor, self.gradientView.backgroundColor?.cgColor as Any]
        self.gradientView?.layer.insertSublayer(gradient, at: 0)
		self.gradientView.backgroundColor = UIColor.clear
	}
	
	@IBAction func BtnBookRead(_ sender: UIButton, forEvent event: UIEvent)
	{
//		let guestBookRead:GuestBookRead = self.storyboard?.instantiateViewController(withIdentifier: "GuestBookRead") as! GuestBookRead
//		guestBookRead.book = self.book

//		let m = book["text"] as! [Dictionary<String, String>]
//		print(m)

		let signInGoogVC:ViewControllerTest = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerTest") as! ViewControllerTest

		self.navigationController?.pushViewController(signInGoogVC, animated: true)

	}
}
