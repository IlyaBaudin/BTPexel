//
//  PhotosListViewController.swift
//  BTPexel
//
//  Created by Ilia Baudin on 26.07.2024.
//

import UIKit
import PexelSDK

/// Photos View Controller that manage photos tableView
class PhotosListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    // MARK: UI
    private let refreshControl = UIRefreshControl()
    
    // MARK: Data
    private var photos: [PexelPhotoProtocol] {
        pexelSDK?.photos ?? []
    }
    
    private var loadingError: Error? {
        pexelSDK?.dataLoadingError
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup controller configuration on controller load
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // refresh data on controller appear
        getPhotos(isInitialLoading: true) {
            self.updateUI()
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
            guard let loadingError = self.loadingError else {
                self.tableView.reloadData()
                return
            }
            self.routeToErrorView(error: loadingError)
        }
    }
    
    // MARK: Data
    /// Download photos from remote storage
    /// - Parameters:
    ///   - isInitialLoading: `true` if we need to perform initial loading OR fully reload data, `false` if need to load next part of data
    ///   - completion: callback that indicates that data has been loaded OR any error happened
    private func getPhotos(isInitialLoading: Bool, completion: @escaping(() -> Void)) {
        pexelSDK?.getPhotos(isInitialLoad: isInitialLoading, completion: { result in
            completion()
        })
    }
    
    // MARK: - Actions
    /// Action that reload data when user pull to refresh `UITableView`
    @objc private func refreshTableView(sender: AnyObject) {
        getPhotos(isInitialLoading: true) {
            self.updateUI()
        }
    }
    
    /// Handle user photo selection
    /// - Parameter indexPath: `IndexPath` in `UITableView` that user tap
    private func selectPhoto(indexPath: IndexPath) {
        guard indexPath.row < photos.count else {
            print("Error: Selected index is out of range")
            return
        }
        pexelSDK?.selectPhoto(photo: photos[indexPath.row])
    }
    
    // MARK: - Routing
    /// Navigate to Detail View Controller
    private func routeToDetailView() {
        guard let photoDetailController = UIStoryboard(name: "PhotoDetail", bundle: nil).instantiateViewController(withIdentifier: "PhotoDetailViewController") as? PhotoDetailViewController else { return }
        self.navigationController?.pushViewController(photoDetailController, animated: true)
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
        return photos.count
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
        guard indexPath.row < photos.count else {
            print("Error: UITableViewCell index is out of range")
            return
        }
        photoCell.configureCell(photo: photos[indexPath.row])
        // simplest and straightforward strategy to load next piece of data
        if indexPath.row == (photos.count - 1) {
            getPhotos(isInitialLoading: false) {
                self.updateUI()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row < photos.count else {
            print("Error: Selected index is out of range")
            return
        }
        selectPhoto(indexPath: indexPath)
        routeToDetailView()
    }
}
