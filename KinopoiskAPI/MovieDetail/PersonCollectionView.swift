//
//  PersinCollectionView.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 12.01.2023.
//

import UIKit

final class PersonCollectionView: UIView {

    private enum Constants {
        static let heightMonth: CGFloat = 32
    }

    // MARK: - Public Properties (Views)

    let personCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.description())
        collection.clipsToBounds = false
        return collection
    }()
    
    private var persons: [Persons] = []


    // MARK: - Lifecycle

    public init() {
        super.init(frame: CGRect.zero)
        configure()
        setupConstraints()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension PersonCollectionView {
    func render(persons: [Persons]) {
        self.persons = persons
        personCollectionView.reloadData()
    }
}

// MARK: - Private Methods

private extension PersonCollectionView {

    func configure() {
        addSubview(personCollectionView)
        personCollectionView.dataSource = self
        personCollectionView.reloadData()
    }

    func setupConstraints() {
        personCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}

extension PersonCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(persons.count)
        return persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.description(), for: indexPath) as? PersonCollectionViewCell else { return UICollectionViewCell() }
        cell.render(person: persons[indexPath.row])
        return cell
    }
}

