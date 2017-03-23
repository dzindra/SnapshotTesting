//
//  MemeGeneratorController.swift
//  memepedia
//
//  Created by Jindrich Dolezy on 09/10/16.
//  Copyright © 2016 STRV. All rights reserved.
//

import UIKit

class MemeGeneratorViewController: UICollectionViewController {
    var viewModel: MemeListViewModel!
    
    var state: MemeListState = .Loading {
        didSet {
            updateState()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onStateChanged { [weak self] newState in
            self?.state = newState
        }
    }
    
    func updateState() {
        collectionView?.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: self.view.bounds.width/2, height: self.view.bounds.width/2)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return state.memes?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.generatorCell, for: indexPath)!
        cell.meme = state.memes?[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let meme = state.memes?[indexPath.row] else { return }
        
        let detailVc = R.storyboard.main.memeGeneratorDetail()!
        detailVc.meme = meme
        show(detailVc, sender: self)
    }
    
}
