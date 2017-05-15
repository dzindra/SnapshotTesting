//
//  SnapshotTestingTests.swift
//  SnapshotTestingTests
//
//  Created by Jindrich Dolezy on 20/03/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import SnapshotTesting


class ViewControllerTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        isDeviceAgnostic = true
        recordMode = ProcessInfo.processInfo.environment["RECORD_MODE"] != nil
    }

    
    func testMemeListViewController() {
        let vc = R.storyboard.main.memeList()!
        let model = StaticMemeListViewModel(state: .Empty)
        
        // if you use more than one view verify in one test method you need to provide additional identifier
        vc.viewModel = model
        FBSnapshotVerifyView(vc.view, identifier: "empty")
        
        model.state = .Loading
        FBSnapshotVerifyView(vc.view, identifier: "loading")
        
        model.state = .Ready(Meme.memes)
        FBSnapshotVerifyView(vc.view, identifier: "ready")
    }
    
    func testMemeDetailViewController() {
        let vc = R.storyboard.main.memeDetail()!
        vc.meme = Meme.memes.first
        FBSnapshotVerifyView(vc.view)
    }
    
    func testMemeGeneratorViewController() {
        let vc = R.storyboard.main.memeGenerator()!
        
        vc.viewModel = StaticMemeListViewModel(state: .Ready(Meme.memes))
        FBSnapshotVerifyView(vc.view)
    }

    func testMemeGeneratorDetailViewController() {
        let vc = R.storyboard.main.memeGeneratorDetail()!
        vc.meme = Meme.memes.first
        vc.bottomLine = "Bottom line"
        vc.topLine = "Top line"
        FBSnapshotVerifyView(vc.view)
    }

    
}


class StaticMemeListViewModel: MemeListViewModel {
    var state: MemeListState {
        didSet {
            changeBlock?(state)
        }
    }
    private var changeBlock: ((MemeListState) -> Void)?
    
    init(state: MemeListState) {
        self.state = state
    }
    
    func onStateChanged(block: @escaping (MemeListState) -> Void) {
        changeBlock = block
        block(state)
    }
    
}
