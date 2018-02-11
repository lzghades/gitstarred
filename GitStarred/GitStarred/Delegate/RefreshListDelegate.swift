//
//  RefreshList.swift
//  GitStarred
//
//  Created by peter on 2018/1/27.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation

protocol RefreshListDelegate {
    func refreshList(finished: @escaping () -> Void)
}
