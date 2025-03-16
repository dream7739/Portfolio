//
//  PortfolioViewController.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import UIKit
import SnapKit

final class PortfolioViewController: UIViewController {
    enum Literal {
        static let infoButtonTitle = "ETF란?"
        static let title = "선진시장 주식"
        static let description = "각 ETF 종목별 기본 정보, 보유 수량,\n최근 1일 수익률 정보입니다"
    }
    
    private let backButton = UIButton()
    private let etfInfoButton = UIButton()
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let tableView = UITableView()
    
    let viewModel: PortfolioViewModel
    
    init(viewModel: PortfolioViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationTitle()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureNavigationTitle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .stock1
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        navigationItem.backButtonTitle = ""
       
        etfInfoButton.setTitle(Literal.infoButtonTitle, for: .normal)
        etfInfoButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        etfInfoButton.backgroundColor = .clear
        etfInfoButton.setTitleColor(.white, for: .normal)
        etfInfoButton.layer.cornerRadius = 13
        etfInfoButton.layer.borderColor = UIColor.white.cgColor
        etfInfoButton.layer.borderWidth = 1
        etfInfoButton.frame = CGRect(x: 0, y: 10, width: 65, height: 25)
        
        let etfInfoBarButtonItem = UIBarButtonItem(customView: etfInfoButton)
        etfInfoButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        navigationItem.rightBarButtonItem = etfInfoBarButtonItem
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureHierarchy() {
        view.addSubview(headerView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .backgroundSecondary
        
        headerView.backgroundColor = .stock1
        
        titleLabel.text = Literal.title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        descriptionLabel.text = Literal.description
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 2
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            PortfolioTableViewCell.self,
            forCellReuseIdentifier: PortfolioTableViewCell.reuseIdentifier
        )
        tableView.rowHeight = 180
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
}

extension PortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.assetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioTableViewCell.reuseIdentifier, for: indexPath) as? PortfolioTableViewCell else { return UITableViewCell() }
        let asset = viewModel.assetList[indexPath.row]
        cell.configureData(asset)
        
        return cell
    }
}
