//
//  StaticMemeListViewModel.swift
//  SnapshotTesting
//
//  Created by Jindrich Dolezy on 21/03/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation


enum MemeListState {
    case Loading
    case Empty
    case Ready([Meme])

    var memes: [Meme]? {
        if case .Ready(let memes) = self {
            return memes
        } else {
            return nil
        }
    }
}

protocol MemeListViewModel {
    func onStateChanged(block: @escaping (MemeListState) -> Void)
}

class DummyLoadingMemeListViewModel: MemeListViewModel {
    let memes: [Meme]
    let delay: Int
    
    init(memes: [Meme], delay: Int = 1000) {
        self.memes = memes
        self.delay = delay
    }
    
    func onStateChanged(block: @escaping (MemeListState) -> Void) {
        block(.Loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            block(.Ready(self.memes))
        }
    }
    
}
