//
//  MemeListViewController.swift
//  memepedia
//
//  Created by Jindrich Dolezy on 09/10/16.
//  Copyright © 2016 STRV. All rights reserved.
//

import UIKit

class MemeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var emptyView: UIView!
    
    var viewModel: MemeListViewModel!

    var state: MemeListState = .Loading {
        didSet {
            updateState()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 61
        
        viewModel.onStateChanged { [weak self] newState in
            self?.state = newState
        }
        updateState()
    }
    
    func updateState() {
        switch state {
        case .Empty:
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 0
                self.loadingView.alpha = 0
                self.emptyView.alpha = 1
            }
        case .Loading:
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 0
                self.loadingView.alpha = 1
                self.emptyView.alpha = 0
            }
        case .Ready(_):
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
                self.loadingView.alpha = 0
                self.emptyView.alpha = 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.memes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.memeListCell, for: indexPath)!
        cell.meme = state.memes?[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selection = tableView.indexPathForSelectedRow,
            let meme = state.memes?[selection.row],
            let info = R.segue.memeListViewController.memeListDetailSegue(segue: segue) {
            
            info.destination.meme = meme
        }
    }
    
}
