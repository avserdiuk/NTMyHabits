//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 04.10.2024.
//

import UIKit

class HabitDetailsViewController : UIViewController {
    var habit: Habit?
    
    private lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        title = habit?.name
        view.backgroundColor = .secondarySystemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(didTapBtn))
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }
    
    @objc func didTapBtn() {
        let vc = HabitViewController()
        vc.habit = habit
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HabitDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.text = dateFormatter.string(from: HabitsStore.shared.dates[indexPath.row])
        cell.accessoryType = HabitsStore.shared.habit(habit!, isTrackedIn: HabitsStore.shared.dates[indexPath.row]) ? .checkmark : .none
        cell.tintColor = UIColor(named: "purpleColor")
        
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
}
