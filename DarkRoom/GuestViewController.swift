//
//  GuestViewController.swift
//  Rus_dialog
//
//  Created by Игорь Дмитриев on 19.07.17.
//  Copyright © 2017 Игорь Дмитриев. All rights reserved.
//
import Foundation
import UIKit

public class GuestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet  var tableViewBooksGuest: UITableView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    
    var animals:[String:AnyObject]? = nil// = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    // cell reuse var(cells that scroll out of view can be reused)
    let cellReuseIdentifier:String = "CellBookId"
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        //self.tableViewBooksGuest.register(CellBook.self, forCellReuseIdentifier: cellReuseIdentifier)//ster(CellBook.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableViewBooksGuest.separatorStyle = UITableViewCellSeparatorStyle.none
		ConnectServer.GetBooks(id: 0 ){books in
			if books != nil
			{
				self.animals = books
				self.tableViewBooksGuest.reloadData()

			}

		}

    }

	override public func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// Hide the navigation bar on the this view controller
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	override public func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		// Show the navigation bar on other view controllers
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}

    // number of rows in table view
     public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if animals != nil
		{
			return (self.animals?.count)!
		}
		return 0
	}
    // create a cell for each table view row
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? CellBook
		if (cell == nil)
		{
			cell = CellBook.init(style: UITableViewCellStyle.default, reuseIdentifier: cellReuseIdentifier)
		}

		if animals == nil
		{
			return cell!
		}

        (cell!).lblBookName?.text = self.animals?["name"]! as! String
		(cell!).lblBookWriter?.text = self.animals?["author"]! as! String
		(cell!).lblBookCountShow?.text = self.animals?["is_view_count"]! as! String

        let gradient = CAGradientLayer()
        gradient.frame = ((cell!).gradientView.bounds)
        gradient.colors = [UIColor.clear.cgColor, (cell!).gradientView.backgroundColor?.cgColor]
        (cell!).gradientView?.layer.insertSublayer(gradient, at: 0)
		(cell!).gradientView.backgroundColor? = UIColor.clear
		if self.animals?["path_cover_file"] != nil
		{
			//let url = URL(string: ConnectServer.URL_IMAGE + (self.animals?[indexPath.row]["path_cover_file"])!)
			(cell!).imgBookBackground.downloadImage(url: ConnectServer.URL_IMAGE + (((self.animals?["path_cover_file"])!) as! String) as! String)

		}

        return cell!
    }
    // method to run when table view cell is tapped
     public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
		let guestDetailViewController:GuestDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "GuestDetailViewController") as! GuestDetailViewController
//		guestDetailViewController.book = (animals?[indexPath.row])!

		guestDetailViewController.imgBackground = (self.tableViewBooksGuest.cellForRow(at: indexPath) as! CellBook).imgBookBackground.image
		self.navigationController?.pushViewController(guestDetailViewController, animated: true)



    }
    
     public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	 {
        return 230.0//Choose your custom row height
	}
}
