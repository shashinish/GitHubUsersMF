//
//  UserListViewController.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/19/24.
//

import UIKit
import Combine

class UserListViewController: BaseViewController {
    
    let viewModel = UserListViewModel()
    private var disposableBag = Set<AnyCancellable>()
    var currentUserCount: Int = 60
    
    lazy var topTitleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.text = UserListConstants.labelStrings.userListTitle
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    lazy var userListTable: UITableView = {
        let tableView = UITableView.init(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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
        viewModel.fetchUsers(count: currentUserCount)
    }
    
    func setupView(){
        navigationItem.titleView = topTitleLabel
        self.view.addSubview(userListTable)
    }
    
    func setConstaints(){
        userListTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func registerTableCells(){
        userListTable.register(UserListTableViewCell.self, forCellReuseIdentifier: UserListConstants.cellIdentifires.userListCellIdentifire)
    }
}

extension UserListViewController {
    
    private func bind(){
        viewModel.userListPublisher
            .sink { [weak self] userList in
                self?.hideProgress()
                self?.userListTable.reloadData()
            }.store(in: &disposableBag)
        
        viewModel.errorPublisher
            .sink { [weak self] error in
                debugPrint(error.localizedDescription)
                self?.hideProgress()
            }.store(in: &disposableBag)
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UserListTableViewCell = (tableView.dequeueReusableCell(withIdentifier: UserListConstants.cellIdentifires.userListCellIdentifire) as? UserListTableViewCell)!
        if let user = viewModel.getUser(index: indexPath.row) {
            cell.configureCell(user: user)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let user = viewModel.getUser(index: indexPath.row) {
            let viewController = UserRepoViewController.init(userListObject: user)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}


extension UserListViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            scrollingFinished()
        }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollingFinished()
    }

    func scrollingFinished() {
        // MARK: Commented and Disabled by author. Can enable to fetch more
        //showProgress()
        //currentUserCount += 0
        //viewModel.fetchUsers(count: currentUserCount)
    }
}
