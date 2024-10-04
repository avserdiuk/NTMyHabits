//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 01.10.2024.
//

import UIKit

class HabitCollectionViewCell : UICollectionViewCell {
    
    var habit: Habit?
    weak var delegate: HabitsViewController?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выпить стакан воды"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в 7:30"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(named: "systemGray2Color")
        return label
    }()
    
    private lazy var checkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 19
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var checkImageView: UIView = {
        let view = UIImageView(image: UIImage(named: "check"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.text = "Счетчик: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "systemGrayColor")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(checkView)
        checkView.addSubview(checkImageView)
        addSubview(footerLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: super.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 230),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subTitleLabel.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 20),
            
            checkView.centerYAnchor.constraint(equalTo: super.centerYAnchor),
            checkView.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -25),
            checkView.heightAnchor.constraint(equalToConstant: 38),
            checkView.widthAnchor.constraint(equalToConstant: 38),
            
            checkImageView.centerXAnchor.constraint(equalTo: checkView.centerXAnchor),
            checkImageView.centerYAnchor.constraint(equalTo: checkView.centerYAnchor),
            checkImageView.heightAnchor.constraint(equalToConstant: 15),
            checkImageView.widthAnchor.constraint(equalToConstant: 15),
            
            footerLabel.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -20),
            footerLabel.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 20),
            
            
        ])
        
        checkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCheckView)))
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        guard let habit else { return }
        titleLabel.text = habit.name
        titleLabel.textColor = habit.color
        checkView.layer.borderColor = habit.color.cgColor
        subTitleLabel.text = "Каждый день в \(dateFormatter.string(from: habit.date))"
        footerLabel.text = "Счетчик \(habit.trackDates.count)"
        
        guard habit.isAlreadyTakenToday else { return }
        self.checkView.backgroundColor = habit.color
        checkImageView.isHidden = false
        
    }
    
    @objc func didTapCheckView(){
        guard let habit else { return }
        guard !habit.isAlreadyTakenToday else { return }
        checkView.backgroundColor = UIColor(cgColor: checkView.layer.borderColor!)
        checkImageView.isHidden = false
        footerLabel.text = "Счетчик \(habit.trackDates.count + 1)"
        HabitsStore.shared.track(habit)
        
        
        guard let delegate else { return }
        delegate.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
    }
    
    @objc func didTapView(){
        let vc = HabitDetailsViewController()
        vc.habit = habit
        delegate?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
