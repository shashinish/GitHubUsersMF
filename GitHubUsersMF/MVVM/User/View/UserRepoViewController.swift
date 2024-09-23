//
//  UserRepoViewController.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/22/24.
//

import UIKit
import Combine

class UserRepoViewController: BaseViewController {
    
    var viewModel: UserRepoViewModel?
    private var disposableBag = Set<AnyCancellable>()
    
    lazy var topTitleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.text = UserConstants.labelStrings.userRepoTitle
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    lazy var repoInfoTable: UITableView = {
        let tableView = UITableView.init(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setConstaints()
        registerTableCells()
        bind()
        showProgress()
        viewModel?.fetchUser()
    }
    
    func setupView(){
        navigationItem.titleView = topTitleLabel
        self.view.addSubview(repoInfoTable)
    }
    
    func setConstaints(){
        repoInfoTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setTableHeader(){
        if let user = viewModel?.user {
            repoInfoTable.tableHeaderView = UserInfoView(user: user)
        }
    }
    
    func registerTableCells(){
        repoInfoTable.register(DetailItemTableViewCell.self, forCellReuseIdentifier: UserConstants.cellIdentifires.userDetailCellIdentifire)
        repoInfoTable.register(RepoDetailTableViewCell.self, forCellReuseIdentifier: UserConstants.cellIdentifires.userRepoCellIdentifire)
    }
    
    init(userListObject: UserList) {
        super.init(nibName: nil, bundle: nil)
        viewModel = UserRepoViewModel(user: userListObject)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension UserRepoViewController {
    
    private func bind(){
        viewModel?.userPublisher
            .sink { [weak self] user in
                self?.hideProgress()
                self?.setTableHeader()
                self?.repoInfoTable.reloadData()
            }.store(in: &disposableBag)
        
        viewModel?.repoPublisher
            .sink { [weak self] repoList in
                self?.hideProgress()
                self?.repoInfoTable.reloadData()
            }.store(in: &disposableBag)
        
        viewModel?.errorPublisher
            .sink { [weak self] error in
                debugPrint(error.localizedDescription)
                self?.hideProgress()
            }.store(in: &disposableBag)
    }
}

extension UserRepoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + (viewModel?.repoCount ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DetailItemTableViewCell = (tableView.dequeueReusableCell(withIdentifier: UserConstants.cellIdentifires.userDetailCellIdentifire) as? DetailItemTableViewCell)!
        
        guard let user = viewModel?.user else {
            return UITableViewCell()
        }

        switch indexPath.row {
        case 0:
            cell.setData(title: UserConstants.tableLegends.company, infoText: user.company ?? UserConstants.labelStrings.notAvailable)
        case 1:
            cell.setData(title: UserConstants.tableLegends.location, infoText: user.location ?? UserConstants.labelStrings.notAvailable)
        case 2:
            cell.setData(title: UserConstants.tableLegends.repos, infoText: "")
        default:
            
            let repocell:RepoDetailTableViewCell = (tableView.dequeueReusableCell(withIdentifier: UserConstants.cellIdentifires.userRepoCellIdentifire) as? RepoDetailTableViewCell)!
            
            guard let repo = viewModel?.getRepoItem(index: indexPath.row - 3) else {
                return UITableViewCell()
            }
            
            repocell.setData(repo: repo)
            return repocell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 2 {
            guard
                let repo = viewModel?.getRepoItem(index: indexPath.row - 3),
                let htmlURL = repo.htmlURL,
                let name = repo.name
            else {
                return
            }
            
            let webViewController = WebViewController.init(repoUrl: htmlURL, repoName: name)
            self.navigationController?.pushViewController(webViewController, animated: true)
        }
    }
}
