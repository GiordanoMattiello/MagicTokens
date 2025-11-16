//
//  ApplyFilterDelegateMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 16/11/25.
//

@testable import MagicTokens

final class ApplyFilterDelegateMock: ApplyFilterDelegate {
    private(set) var fetchTokensWithFilterCallCount = 0
    private(set) var receivedFilterUrl: String?
    
    func fetchTokensWithFilter(filterUrl: String) {
        fetchTokensWithFilterCallCount += 1
        receivedFilterUrl = filterUrl
    }
}
