//
//  GuestBookRead.swift
//  Rus_dialog
//
//  Created by Игорь Дмитриев on 28.07.17.
//  Copyright © 2017 Игорь Дмитриев. All rights reserved.
//

import UIKit
import Foundation

public class GuestBookRead: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	@IBOutlet
	weak var messageTableView: UITableView!

	var messages:[Dictionary<String, AnyObject>] = []
	var readMessages:[Dictionary<String, String>] = []
	let cellAIdentifier:String = "messageA"
	let cellBIdentifier:String = "messageB"
	let cellCIdentifier:String = "messageC"
	var i:Int = 2
	var nameA:String = ""
	var nameB:String = ""

	var book:Dictionary<String, AnyObject> = [:]

	override public func viewDidLoad() {
//		ConnectServer.GetMessagesByBookId(id: Int(book["id_book"]!)!, flag: false) {messages in
//			self.messages = messages
//			self.nameA = self.messages[0]["nameA"]!
//			self.nameB = self.messages[1]["nameB"]!
////			self.readMessages.append(self.messages[self.i])
////			self.messageTableView.reloadData()
//		}

		self.messageTableView.estimatedRowHeight = 80
		self.messageTableView.rowHeight = UITableViewAutomaticDimension
		self.navigationItem.title = self.book["name"] as! String
		self.messages = self.book["text"] as! [Dictionary<String, AnyObject>]
		if self.messages.count > 0
		{
			self.nameA = self.messages[0]["nameA"]! as! String
			self.nameB = self.messages[1]["nameB"]! as! String
		}
	}

	// number of rows in table view
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if self.readMessages != nil || self.readMessages.count != 0
		{
			return (self.readMessages.count)
		}
		return 0
	}

    // create a cell for each table view row
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var currentName:String = ""
		var currentMessage:String = ""
		var currentIdentefier:String = ""

		for (key, value) in self.readMessages[indexPath.row]
		{
			currentMessage = value

			switch key
			{
				case "peopleB":
					currentName = self.nameB
					currentIdentefier = self.cellAIdentifier
				case "peopleA":
					currentName = self.nameA
					currentIdentefier = self.cellBIdentifier
				default :
					currentIdentefier = self.cellCIdentifier

			}
		}

		print("currentName = \(currentName)")
		print("currentMessage = \(currentMessage)")

		let cell:CellBookRead = tableView.dequeueReusableCell(withIdentifier: currentIdentefier, for: indexPath) as! CellBookRead

		cell.lblMessage.text = currentMessage




		if currentIdentefier != self.cellCIdentifier
		{
			cell.lblUser.text = currentName
			cell.backgroundViewMessage.layer.shadowColor = UIColor.black.cgColor
			cell.backgroundViewMessage.layer.shadowOpacity = 0.3
			cell.backgroundViewMessage.layer.shadowOffset = CGSize.zero
			cell.backgroundViewMessage.layer.shadowRadius = 2
//			if currentIdentefier == self.cellAIdentifier
//			{
//				cell.backgroundViewMessage.layer.borderColor = UIColor.init(displayP3Red: 0xf1, green: 0xCC, blue: 0xD2, alpha: 0xFF).cgColor
//			}
//			else
//			{ª

//				cell.backgroundViewMessage.layer.borderColor = UIColor.init(displayP3Red: 0xD5, green: 0xDF, blue: 0xD7, alpha: 0xFF).cgColor
//			}
		}
		if indexPath.row == self.readMessages.count - 1
		{

			self.btnFullScreen.isHidden = false
			cell.contentView.alpha = 0.0
			UIView.animate(withDuration: 0.7, animations: {
				cell.contentView.alpha = 1.0

			})
		}

		return cell
    }

    // method to run when table view cell is tapped
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
		RefreshShowMessages()
    }


	@IBOutlet weak var btnFullScreen: UIButton!
	func RefreshShowMessages()
	{
		if i < self.messages.count
		{
			self.readMessages.append(self.messages[self.i] as! [String : String])
			self.messageTableView.reloadData()

			let _indexPathForScrollToBottom = IndexPath(row: self.i - 2, section: 0)
			self.messageTableView.scrollToRow(at: _indexPathForScrollToBottom, at: UITableViewScrollPosition.top, animated: false)
			i += 1
		}
	}

	@IBAction
	func BtnShowMessage(_ sender: UIButton, forEvent event: UIEvent)
	{
		self.btnFullScreen.setTitle(" ", for: UIControlState.normal)
		RefreshShowMessages()
		let countUnvisible:Int = self.readMessages.count - self.messageTableView.visibleCells.count
		print("Count = \(countUnvisible)")
		if countUnvisible > 0
		{
			sender.isHidden = true
			//self.btnFullScreen.isEnabled = false
		}
	}

}
