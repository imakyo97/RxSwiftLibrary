//
//  SettingsViewModel.swift
//  RxDataSourcesTraining
//
//  Created by 今村京平 on 2021/08/12.
//

import RxSwift
import RxCocoa
import RxDataSources

class SettingViewModel {

    private let items = BehaviorRelay<[SettingsSectionModel]>(value: [])

    var itemsObservable: Observable<[SettingsSectionModel]> {
        return items.asObservable()
    }

    func setup() {
        updateItems()
    }

    private func updateItems() {
        let sections: [SettingsSectionModel] = [
        accountSection(),
        commonSection(),
        otherSection()
        ]

        items.accept(sections)
    }

    private func accountSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
            .account,
            .security,
            .notification,
            .contents
        ]
        return SettingsSectionModel(model: .account, items: items)
    }

    private func commonSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
            .sounds,
            .dataUsing,
            .accessibility,
            .description(text: "基本設定はこの端末でログインしている全てのアカウントに適用されます。")
        ]
        return SettingsSectionModel(model: .common, items: items)
    }

    private func otherSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
            .credits,
            .version,
            .privacyPolicy
        ]
        return SettingsSectionModel(model: .other, items: items)
    }
}
