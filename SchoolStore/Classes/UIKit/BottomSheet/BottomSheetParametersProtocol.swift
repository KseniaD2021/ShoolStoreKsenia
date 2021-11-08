//
//  BottomSheetParametersProtocol.swift
//  SchoolStore
//
//  Created by Ксения Дураева on 01.11.2021.
//

import Foundation

public protocol BottomSheetParametersProtocol {
    var hasArrow: Bool {
        get
    }
    var shouldDismissOnTapOut: Bool {
        get
    }
    var contentView: ScrollableView {
        get
    }
    var customOnLoadSideEffect: (() -> Void)? {
        get
    }
    var customTapOutAction: (() -> Void)? {
        get
    }

    var onEveryTapOut: (() -> Void)? {
        get
    }
}
