//
//  LocalizableKeys.swift
//  BAZProject
//
//  Created by 1017143 on 14/11/22.
//

import Foundation

struct LocalizableKeys {
    struct Home {
        static let title = "title.home".localized
        static let placeHolder = "place.holder.search".localized
        static let cell = "identifier.tableViewCell".localized
        static let collection = "identifier.collectionViewCell".localized
    }
    struct Api {
        static let key = "api.key".localized
        static let urlApi = "url.api".localized
        static let urlImg = "url.img".localized
    }
    struct Categories {
        static let trending = "url.trending".localized
        static let nowPlying = "url.now.playing".localized
        static let popular = "url.popular".localized
        static let rated = "url.top.rated".localized
        static let upComing = "url.upcoming".localized
    }
}
