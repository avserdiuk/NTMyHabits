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
        
        view.backgroundColor = .white
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc func didTapAdd(){
        let vc = UINavigationController(rootViewController: HabitViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
