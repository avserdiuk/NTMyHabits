//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 26.09.2024.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .systemBackground
        
        return scroll
    }()
    
    private lazy var labelTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Привычка за 21 день"
        return label
    }()
    
    private lazy var labelText : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = """
Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.\n
2. Выдержать 2 дня в прежнем состоянии самоконтроля.\n
3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.\n
4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.\n
5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
"""
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Информация"
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(labelTitle)
        scrollView.addSubview(labelText)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            labelTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
            labelTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            labelText.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 16),
            labelText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            labelText.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            labelText.widthAnchor.constraint(equalToConstant: view.frame.width-32)
            
        ])
    }
}
