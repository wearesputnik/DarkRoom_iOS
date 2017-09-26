//
//  ConnectServer.swift
//  Rus_dialog
//
//  Created by Игорь Дмитриев on 19.07.17.
//  Copyright © 2017 Игорь Дмитриев. All rights reserved.
//

import Foundation

public class ConnectServer
{
	static let URL_SERVER = "http://www.wearesputnik.com/development.knigs/index.php/api/"
	static let URL_IMAGE = "http://www.wearesputnik.com/development.knigs/protected"



	public static func GetBooks(id: Int, completionHandler: @escaping (_ books: [String:AnyObject]) -> ())
	{

		let headers = [
			"cache-control": "no-cache"
			//"postman-token": "ae031c5f-fcdb-d4e5-e9d9-5ac466a4c706"
		]

		let request = NSMutableURLRequest(url: NSURL(string: ConnectServer.URL_SERVER + "guest_books")! as URL,
                                        cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)
		request.httpMethod = "GET"
		request.allHTTPHeaderFields = headers

		let session = URLSession.shared
		let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
		if (error != nil){
			print(error)
		}
		else
		{
			do {
            // Convert NSData to Dictionary where keys are of type String, and values are of any type
				//let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
            // Access specific key with value of type String
				let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
//				let str = string as! [String:AnyObject]  //json["result"]
//				print(str)
				completionHandler(json["result"] as! [String : AnyObject])
			} catch {
            // Something went wrong
			}
		}

		})

		dataTask.resume()
	}

	public static func GetMessagesByBookId(id: Int, flag: Bool, completionHandler: @escaping (_ messages: [[String:String]]) -> ())
	{
		let headers = [
			"cache-control": "no-cache"
		]

		let request = NSMutableURLRequest(url: NSURL(string: ConnectServer.URL_SERVER + "descript_book?id=" + String(id) + "&flag=" + String(flag))! as URL,
                                        cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)
		request.httpMethod = "GET"
		request.allHTTPHeaderFields = headers

		let session = URLSession.shared
		let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
			if (error != nil) {
				print(error)
			} else {
				let httpResponse = response as? HTTPURLResponse
				//print(httpResponse)
				let string = String(data: data!, encoding: String.Encoding.utf8)
				//print(string)
			}
			do {
            // Convert NSData to Dictionary where keys are of type String, and values are of any type
				let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
            // Access specific key with value of type String
				let str = json["result"]!["text"] as! [[String:String]]
				print(str[0])
				completionHandler(str as! [[String : String]])
			} catch {
            // Something went wrong
			}
		})

		dataTask.resume()
	}



}

