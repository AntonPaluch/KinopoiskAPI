//
//  PersonCollectionViewCell.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 12.01.2023.
//

import UIKit

public final class PersonCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let imageSize: CGSize = CGSize(width: 130, height: 160)
    }

    // MARK: - Views
    
    private let personImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    // MARK: - Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: - Public Methods

extension PersonCollectionViewCell {

    func render(person: Persons?) {
        if let description = person?.description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = person?.enProfession
        }
        nameLabel.text = person?.name
        personImageView.setImageFromUrl(imageUrl: person?.photo ?? "")
    }
}

// MARK: - Private Methods

private extension PersonCollectionViewCell {

    func setupViews() {
        contentView.addViews([personImageView, nameLabel, descriptionLabel])
    }

    func setupConstraints() {
        
        personImageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.size.equalTo(Constants.imageSize)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(personImageView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}

