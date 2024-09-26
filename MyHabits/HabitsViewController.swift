//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 26.09.2024.
//

import UIKit

class HabitsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }
}
