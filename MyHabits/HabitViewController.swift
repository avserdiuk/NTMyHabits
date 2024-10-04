//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 27.09.2024.
//

import UIKit

class HabitViewController : UIViewController {
    
    var habit : Habit?
    
    private lazy var labelText1 : UILabel = {
       let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textInput : UITextField = {
       let textInput = UITextField()
        textInput.placeholder = "Например: бегать по утрам"
        textInput.translatesAutoresizingMaskIntoConstraints = false
        return textInput
    }()
    
    private lazy var labelText2 : UILabel = {
       let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewColor: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemBlue
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var labelText3 : UILabel = {
       let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelText4 : UILabel = {
       let label = UILabel()
        label.text = "Каждый день в "
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelText5 : UILabel = {
       let label = UILabel()
        label.text = "11:00 "
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
       let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        return picker
    }()
    
    private lazy var deleteButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Удалить привычку", for: .normal)
        btn.setTitleColor(.systemRed, for: .normal)
        btn.isHidden = true
        btn.addTarget(self, action: #selector(didTapDeleteBtn), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        title = "Создать"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(didTapSave))
        
        view.addSubview(labelText1)
        view.addSubview(textInput)
        view.addSubview(labelText2)
        view.addSubview(viewColor)
        view.addSubview(labelText3)
        view.addSubview(labelText4)
        view.addSubview(timePicker)
        view.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            
            labelText1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            labelText1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            textInput.topAnchor.constraint(equalTo: labelText1.bottomAnchor, constant: 7),
            textInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            labelText2.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: 15),
            labelText2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            viewColor.topAnchor.constraint(equalTo: labelText2.bottomAnchor, constant: 7),
            viewColor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            viewColor.heightAnchor.constraint(equalToConstant: 30),
            viewColor.widthAnchor.constraint(equalToConstant: 30),
            
            labelText3.topAnchor.constraint(equalTo: viewColor.bottomAnchor, constant: 15),
            labelText3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            labelText4.topAnchor.constraint(equalTo: labelText3.bottomAnchor, constant: 7),
            labelText4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            timePicker.centerYAnchor.constraint(equalTo: labelText4.centerYAnchor),
            timePicker.leadingAnchor.constraint(equalTo: labelText4.trailingAnchor, constant: 1),
            
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
            
        ])
        
        viewColor.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapColorView)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let habit else { return }
        setup(habit)
    }
    
    func setup(_ habit: Habit){
        textInput.text = habit.name
        timePicker.date = habit.date
        viewColor.backgroundColor = habit.color
        
        deleteButton.isHidden = false
    }
    
    @objc func didTapDeleteBtn(){
        guard let habit else { return }
        
        let message = "Вы хотите удалить привычку \"\(habit.name)\"?"
        let alert = UIAlertController(title: "Удалить привычку", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            HabitsStore.shared.habits.removeAll {
                $0 == self.habit
            }

            self.navigationController?.popToViewController((self.navigationController!.viewControllers.first)!, animated: true)
            
        }
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    @objc func didTapCancel(){
        
        if habit != nil {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    @objc func didTapSave(){
        
        if habit != nil {
            
            habit?.name = textInput.text ?? ""
            habit?.color = viewColor.backgroundColor ?? .white
            habit?.date = timePicker.date
            
            navigationController?.popToViewController((navigationController!.viewControllers.first)!, animated: true)
        } else {
            
            var title = textInput.text ?? ""
            
            if title == "" {
                title = "Новая привычка"
            }
            
            let newHabit = Habit(name: title,
                                 date: timePicker.date,
                                 color: viewColor.backgroundColor ?? .white)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
            dismiss(animated: true)
        
        }
        
    }
    
    @objc func didTapColorView(){
        let vs = UIColorPickerViewController()
        vs.delegate = self
        vs.selectedColor = UIColor(cgColor: self.viewColor.backgroundColor?.cgColor ?? CGColor(gray: 1, alpha: 1))
        present(vs, animated: true)
    }
    
}

extension HabitViewController : UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        self.viewColor.backgroundColor = color
    }
}
