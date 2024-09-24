//
//  RepoDetailTableViewCell.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/22/24.
//


import UIKit
import SnapKit

class RepoDetailTableViewCell: UITableViewCell {
    
    private lazy var repoNameTitleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = UserConstants.tableLegends.repositoryName
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var repoNameLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Info Text"
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var languageTitleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = UserConstants.tableLegends.progLanguage
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Info Text"
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var numOfStarsTitleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = UserConstants.tableLegends.numOfStars
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var numOfStarsLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Info Text"
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = UserConstants.tableLegends.description
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Info Text"
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none

        // Repo Name
        contentView.addSubview(repoNameTitleLabel)
        repoNameTitleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(repoNameLabel)
        repoNameLabel.snp.makeConstraints { make in
            make.top.equalTo(repoNameTitleLabel.snp.bottom).inset(-5)
            make.left.right.equalToSuperview().inset(20)
        }
        
        // Language
        contentView.addSubview(languageTitleLabel)
        languageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(repoNameLabel.snp.bottom).inset(-5)
            make.left.right.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(languageLabel)
        languageLabel.snp.makeConstraints { make in
            make.top.equalTo(languageTitleLabel.snp.bottom).inset(-5)
            make.left.right.equalToSuperview().inset(20)
        }
        
        // Number of stars
        contentView.addSubview(numOfStarsTitleLabel)
        numOfStarsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(languageLabel.snp.bottom).inset(-5)
            make.left.right.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(numOfStarsLabel)
        numOfStarsLabel.snp.makeConstraints { make in
            make.top.equalTo(numOfStarsTitleLabel.snp.bottom).inset(-5)
            make.left.right.equalToSuperview().inset(20)
        }
        
        // Description
        contentView.addSubview(descriptionTitleLabel)
        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(numOfStarsLabel.snp.bottom).inset(-5)
            make.left.right.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).inset(-5)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setData(repo: Repo) {
        repoNameLabel.text = repo.name
        languageLabel.text = repo.language
        numOfStarsLabel.text = "\(repo.stargazersCount)"
        descriptionLabel.text = repo.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
