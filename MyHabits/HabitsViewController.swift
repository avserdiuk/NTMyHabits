//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 26.09.2024.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var layout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 18
        layout.sectionInset = UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)
        return layout
    }()
    
     lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        collection.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "progressCell")
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "habitCell")
        collection.backgroundColor = .secondarySystemBackground
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationController?.navigationBar.tintColor = UIColor(named: "purpleColor")
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
    @objc func didTapAdd(){
        let vc = UINavigationController(rootViewController: HabitViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension HabitsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressCell", for: indexPath) as! ProgressCollectionViewCell
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.setup(progress: HabitsStore.shared.todayProgress)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitCell", for: indexPath) as! HabitCollectionViewCell
            cell.delegate = self
            cell.habit = HabitsStore.shared.habits[indexPath.item-1]
            cell.setup()
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 60
        
        if indexPath.item != 0 {
            height = 130
        }
        return CGSize(width: UIWindow().frame.width - 32, height: height)
    }
    
    
    
    
}
