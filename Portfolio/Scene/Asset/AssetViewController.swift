//
//  AssetViewController.swift
//  PracticeGraph
//
//  Created by 홍정민 on 3/16/25.
//

import UIKit
import SnapKit
import Toast

final class AssetViewController: UIViewController {
    private let graphView = CircleGraphView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let stockStackView = UIStackView()
    private let stockTitleLabel = UILabel()
    private let developedStockView = ProgressView(type: .developedStock)
    private let advancedStockView = ProgressView(type: .advancedStock)
  
    private let bondStackView = UIStackView()
    private let bondTitleLabel = UILabel()
    private let developedBondView = ProgressView(type: .developedBond)
    private let advencedBondView = ProgressView(type: .advancedBond)
    
    private let etcStackView = UIStackView()
    private let etcTitleLabel = UILabel()
    private let etcView = ProgressView(type: .etc)
    private let alternativeView = ProgressView(type: .alternative)
    
    private let viewModel: AssetViewModel
    
    init(viewModel: AssetViewModel) {
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
        configureAssetList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // 네비게이션 타이틀 설정
    private func configureNavigationTitle() {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = AssetName.retirement
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    // 뷰 계층 설정
    private func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(graphView)
        
        view.addSubview(stockStackView)
        stockStackView.addArrangedSubview(stockTitleLabel)
        stockStackView.addArrangedSubview(advancedStockView)
        stockStackView.addArrangedSubview(developedStockView)
        
        view.addSubview(bondStackView)
        bondStackView.addArrangedSubview(bondTitleLabel)
        bondStackView.addArrangedSubview(advencedBondView)
        bondStackView.addArrangedSubview(developedBondView)
        
        view.addSubview(etcStackView)
        etcStackView.addArrangedSubview(etcTitleLabel)
        etcStackView.addArrangedSubview(etcView)
        etcStackView.addArrangedSubview(alternativeView)
    }
    
    // 뷰 레이아웃 설정
    private func configureLayout() {
        graphView.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(graphView).offset(20)
            make.leading.equalTo(graphView.snp.trailing).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        stockStackView.snp.makeConstraints { make in
            make.top.equalTo(graphView.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        bondStackView.snp.makeConstraints { make in
            make.top.equalTo(stockStackView.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        etcStackView.snp.makeConstraints { make in
            make.top.equalTo(bondStackView.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
    }
    
    // 뷰 속성 설정
    private func configureView() {
        view.backgroundColor = .darkBlack

        graphView.backgroundColor = .darkBlack
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(graphViewTapped))
        graphView.addGestureRecognizer(tapGesture)
        graphView.isUserInteractionEnabled = true

        titleLabel.numberOfLines = 2
        titleLabel.textColor = .textPrimary
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = "장기투자에 적합한\n적극적인 자산배분"
        
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textColor = .textSecondary
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .medium)
        descriptionLabel.text = "'\(AssetName.retirement)'에\n최적화된 자산배분입니다"

        let attrString = NSMutableAttributedString(string: descriptionLabel.text!)
    
        let range = (descriptionLabel.text! as NSString).range(of: "'\(AssetName.retirement)'")
        attrString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor.textPrimary,
            range: range
        )
        attrString.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 12, weight: .semibold),
            range: range
        )
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attrString.length)
        )
        
        descriptionLabel.attributedText = attrString
        
        
        // 주식형 자산
        stockTitleLabel.textColor = .textSecondary
        stockTitleLabel.font = .systemFont(ofSize: 12)
        stockTitleLabel.text = PortfolioType.stock.name
        
        stockStackView.axis = .vertical
        stockStackView.distribution = .fillEqually
        stockStackView.spacing = 15
        
        // 채권형 자산
        bondTitleLabel.textColor = .textSecondary
        bondTitleLabel.font = .systemFont(ofSize: 12)
        bondTitleLabel.text = PortfolioType.bond.name
        
        bondStackView.axis = .vertical
        bondStackView.distribution = .fillEqually
        bondStackView.spacing = 15
        
        // 기타 자산
        etcTitleLabel.textColor = .textSecondary
        etcTitleLabel.font = .systemFont(ofSize: 12)
        etcTitleLabel.text = PortfolioType.etc.name
        
        etcStackView.axis = .vertical
        etcStackView.distribution = .fillEqually
        etcStackView.spacing = 15
    }
    
    @objc func graphViewTapped() {
        guard let assetList = viewModel.portfolio?.data.assetList else { return }
        let viewModel = PortfolioViewModel(assetList: assetList)
        navigationController?.pushViewController(
            PortfolioViewController(viewModel: viewModel),
            animated: true
        )
    }
    
    // 자산리스트 json 로드
    private func configureAssetList() {
        guard let portFolio = viewModel.readPortfolio() else {
            view.makeToast("보유한 자산이 없습니다")
            return
        }
        
        // 선진, 신흥 구분이 없이 데이터가 있기 때문에 편의상 모두 선진(주식/채권)이라고 가정
        let asset = portFolio.data.assetList
        let stock = asset.filter { $0.type == PortfolioType.stock.rawValue }.map { $0.ratio }.reduce(0, +)
        let bond = asset.filter { $0.type == PortfolioType.bond.rawValue }.map { $0.ratio }.reduce(0, +)
        let etc = asset.filter { $0.type == PortfolioType.etc.rawValue }.map { $0.ratio }.reduce(0, +)
        
        // 원형 그래프 업데이트
        graphView.updateValues([stock, bond, etc])
        
        // 주식형 자산
        advancedStockView.updateValue(Float(stock))
        
        // 채권형 자산
        advencedBondView.updateValue(Float(bond))
        
        // 기타 자산
        etcView.updateValue(Float(etc))
    }
    
}

