//
//  SettingsViewController.swift
//  RxDataSourcesTraining
//
//  Created by 今村京平 on 2021/08/12.
//

import UIKit
import RxSwift
import RxDataSources

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var disposeBag = DisposeBag()

    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SettingsSectionModel>(
        configureCell: configureCell)

    private lazy var configureCell: RxTableViewSectionedReloadDataSource<SettingsSectionModel>.ConfigureCell =
        { [weak self] (dataSource, tableView, indexPath, _) in
            let item = dataSource[indexPath]
            switch item {
            case .account, .security, .notification, .contents,
                 .sounds, .dataUsing, .accessibility:
                let cell = tableView
                    .dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = item.title
                cell.accessoryType = item.accessoryType
                return cell
            case .description(let text):
                let cell = tableView
                    .dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = text
                cell.isUserInteractionEnabled = false
                return cell
            }
        }

    private var viewModel: SettingViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
        setupTableView()
        setupViewModel()
    }

    private func setupViewController() {
        navigationItem.title = "設定"
    }

    private func setupTableView() {
        tableView
            .register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset.bottom = 12.0
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.itemSelected
            .subscribe(onNext: {[weak self] indexPath in
                guard let item = self?.dataSource[indexPath] else { return }
                self?.tableView.deselectRow(at: indexPath, animated: true)
                switch item {
                case .account:
                    // 遷移させる処理
                    // コンパイルエラー回避のためにbreakを書いていればbreakは必要ありません
                    break
                case .security:
                    // 遷移させる処理
                    break
                case .notification:
                    // 遷移させる処理
                    break
                case .contents:
                    // 遷移させる処理
                    break
                case .sounds:
                    // 遷移させる処理
                    break
                case .dataUsing:
                    // 遷移させる処理
                    break
                case .accessibility:
                    // 遷移させる処理
                    break
                case .description:
                    // 遷移させる処理
                    break
                }
            })
            .disposed(by: disposeBag)
    }

    private func setupViewModel() {
        viewModel = SettingViewModel()
        viewModel.itemsObservable
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.setup()
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath]
        return item.rowHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.headerHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.footerHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}
