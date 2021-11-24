//
//  AlbumsVC.swift
//  qwert
//
//  Created by Anastasiya on 16.11.21.
//

import UIKit

class AlbumsVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getAlboms(clouser: { [weak self] error in
            if let error = error {
                print(error)
            } else {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desination = segue.destination as? PhotosCollectionVC,
           let album = sender as? Album {
            desination.album = album
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AlbumsCellVC
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        // достаем cellViewModel по indexPath
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        // присваиваем cellViewModel
        tableViewCell.viewModel = cellViewModel
        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        // сохраним выбранный indexPath в TableViewViewModel
        viewModel.selectRow(atIndexPath: indexPath)
        performSegue(withIdentifier: "goToPHotosVC", sender: nil)
    }
    
    var viewModel: ViewModelAlbumsVCProtocol!
}

