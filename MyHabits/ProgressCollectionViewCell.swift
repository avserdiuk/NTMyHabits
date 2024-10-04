//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 01.10.2024.
//

import UIKit

class ProgressCollectionViewCell : UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(named: "systemGrayColor")
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "50%"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(named: "systemGrayColor")
        return label
    }()
    
    private lazy var progressBar : UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progress = 0.5
        view.progressTintColor = UIColor(named: "purpleColor")
        view.backgroundColor = UIColor(named: "backgroundGray")
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(progressLabel)
        addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: super.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 12),
            
            progressLabel.topAnchor.constraint(equalTo: super.topAnchor, constant: 10),
            progressLabel.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -12),
            
            progressBar.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -12),
            progressBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            progressBar.heightAnchor.constraint(equalToConstant: 7),
            progressBar.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(progress: Float){
        progressBar.progress = progress
        progressLabel.text = "\(Int(progress*100))%"
    }

}
