//
//  ViewController.swift
//  W6D4---StretchySnacks
//
//  Created by Dylan McCrindle on 2016-12-08.
//  Copyright © 2016 Dylan-McCrindle. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var foodStack: UIStackView!
	@IBOutlet weak var navHeight: NSLayoutConstraint!
	@IBOutlet weak var navView: UIView!
	@IBOutlet weak var plus: UIButton!
	@IBOutlet weak var tableView: UITableView!
	
	var isOpen = false
	let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
	var foodArray = [String]()
	
	@IBOutlet weak var oreosView: UIImageView!
	@IBOutlet weak var pizzaView: UIImageView!
	@IBOutlet weak var tartsView: UIImageView!
	@IBOutlet weak var popsicleView: UIImageView!
	@IBOutlet weak var ramenView: UIImageView!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let foodViewArray =  [oreosView, pizzaView, tartsView, popsicleView, ramenView]
		
		
		
		for food in foodViewArray {
			let tap = UITapGestureRecognizer(target: self, action: #selector(addSnack))
			food?.addGestureRecognizer(tap)
			food?.isUserInteractionEnabled = true
		}
		
		self.label.center = self.navView.center
		self.label.textAlignment = .center
		self.label.text = "SNACKS"
		self.view.addSubview(label)
		
//		label.centerXAnchor.constraint(equalTo: self.navView.centerXAnchor).isActive = true
//		label.centerYAnchor.constraint(equalTo: self.navView.centerYAnchor).isActive = true
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	@IBAction func plusButton(_ sender: UIButton) {
		if isOpen {
			
			popMenu(menuHeight: 64, plusAngle: CGFloat.pi/2.0, hide: true)
			isOpen = false
		}
		else{
			popMenu(menuHeight: 140, plusAngle: CGFloat.pi/4.0, hide: false)
			isOpen = true
		}
		
	}

	func popMenu(menuHeight:CGFloat, plusAngle: CGFloat, hide: Bool) -> () {
		UIView.animate(withDuration: 0.4,
		               delay: 0,
		               usingSpringWithDamping: 0.5,
		               initialSpringVelocity: 0.0,
		               options: .curveEaseIn,
		               animations: {
						self.foodStack.translatesAutoresizingMaskIntoConstraints = false
						self.foodStack.leadingAnchor.constraint(
							equalTo: self.navView.leadingAnchor).isActive = true
						self.foodStack.trailingAnchor.constraint(
							equalTo: self.navView.trailingAnchor).isActive = true
						self.foodStack.bottomAnchor.constraint(
							equalTo: self.navView.bottomAnchor).isActive = true
						
						self.foodStack.isHidden = hide
						self.navHeight.constant = menuHeight
						
						//CGAffineTransform.identity is a way to make it go back to the default value
						self.plus.transform = CGAffineTransform(rotationAngle: plusAngle)
						
						if(menuHeight > 100){
							self.label.center.y = (menuHeight/2) - 20
							self.label.text = "ADD A SNACK"
						}
						else{
							self.label.center.y = (menuHeight/2)
							self.label.text = "SNACKS"
						}
						
						self.view.layoutIfNeeded()
		}, completion: nil)
	}
	
	// MARK: Table View
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return foodArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
		cell.textLabel?.text = foodArray[indexPath.row]
		return cell
		
	}
	
	
	
	
	func addSnack(_ sender: UITapGestureRecognizer) {
		
		if sender.view?.tag == 1 {
			foodArray += ["Oreos"]
		}
		else if sender.view?.tag == 2 {
			foodArray += ["Pizza Pocket"]
		}
		else if sender.view?.tag == 3 {
			foodArray += ["Poptarts"]
		}
		else if sender.view?.tag == 4 {
			foodArray += ["Popsicle"]
		}
		else if sender.view?.tag == 5 {
			foodArray += ["Ramen"]
		}
		tableView.reloadData()
	}
}



