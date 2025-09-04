//
//  PhotosListViewController.swift
//  BTPexel
//
//  Created by Ilia Baudin on 26.07.2024.
//

import UIKit
import PexelDomain

/// Photos View Controller that manage photos tableView
class PhotosListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    // MARK: UI
    private let refreshControl = UIRefreshControl()
    
    private lazy var viewModel = FeedViewModel(service: appService())
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup controller configuration on controller load
        setupController()
        
        Task { [weak self] in
            await self?.viewModel.reload()
            self?.updateUI()
        }
    }
    
    // MARK: - Private methods
    /// Setup UI for controller and subviews, set required delegates
    private func setupController() {
        tableView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "photoCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "Pexel Photos"
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshTableView(sender: )), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    /// Trigger redraw UI when data loaded or error happened
    private func updateUI() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            if let error = self.viewModel.loadingError {
                self.routeToErrorView(error: error)
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    /// Action that reload data when user pull to refresh `UITableView`
    @objc private func refreshTableView(sender: AnyObject) {
        Task { [weak self] in
            await self?.viewModel.reload()
            self?.updateUI()
        }
    }
    
    /// Handle user photo selection
    /// - Parameter indexPath: `IndexPath` in `UITableView` that user tap
    private func selectPhoto(indexPath: IndexPath) -> PexelPhoto? {
        guard indexPath.row < viewModel.photos.count else {
            print("Error: Selected index is out of range")
            return nil
        }
        return viewModel.photos[indexPath.row]
    }
    
    // MARK: - Routing
    /// Navigate to Detail View Controller
    private func routeToDetailView(photo: PexelPhoto) {
        guard let photoDetailController = UIStoryboard(name: "PhotoDetail", bundle: nil).instantiateViewController(withIdentifier: "PhotoDetailViewController") as? PhotoDetailViewController else { return }
        photoDetailController.photo = photo
        navigationController?.pushViewController(photoDetailController, animated: true)
    }
    
    /// Navigate to Error View
    /// - Parameter error: data loading error object
    private func routeToErrorView(error: Error?) {
        guard let error else { return }
        let alertController = UIAlertController(title: "Loading error",
                                                message: error.localizedDescription ,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension PhotosListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell")
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension PhotosListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let photoCell = cell as? PhotoCell else {
            print("Error: UITableViewCell has got unexpected type")
            return
        }
        guard indexPath.row < viewModel.photos.count else {
            print("Error: UITableViewCell index is out of range")
            return
        }
        photoCell.configureCell(photo: viewModel.photos[indexPath.row])
        // simplest and straightforward strategy to load next piece of data
        if indexPath.row == (viewModel.photos.count - 1) {
            Task { [weak self] in
                await self?.viewModel.loadMore()
                self?.updateUI()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let photoCell = cell as? PhotoCell else {
            return
        }
        photoCell.cancelImageLoad()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row < viewModel.photos.count else {
            print("Error: Selected index is out of range")
            return
        }
        guard let photo = selectPhoto(indexPath: indexPath) else {
            return
        }
        
        routeToDetailView(photo: photo)
    }
}
