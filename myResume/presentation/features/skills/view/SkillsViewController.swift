//
//  SkillsViewController.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import UIKit

class SkillsViewController: UIViewController {
    var viewModel: SkillsViewModel?
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView?
    @IBOutlet private weak var errorMessageLabel: UILabel?
    @IBOutlet private weak var collectionView: UICollectionView?
    
    static func instantiate() -> SkillsViewController {
        guard let viewController = UIStoryboard(name: "SkillsViewController", bundle: nil).instantiateInitialViewController() as? SkillsViewController else {
            return SkillsViewController()
        }
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.errorMessageLabel?.isHidden = true
        self.collectionView?.dataSource = self
        
        Task {
            await self.viewModel?.load()
        }
    }
}

extension SkillsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel?.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = self.viewModel?.sections?[section] else { return 0 }
        return section.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = self.viewModel?.sections?[indexPath.section] else { return UICollectionViewCell() }
        let item = section.items[indexPath.row]
        guard let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: SkillsCollectionViewCell.identifier, for: indexPath) as? SkillsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.title?.text = item.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SkillsCollectionViewHeader.identifier, for: indexPath) as? SkillsCollectionViewHeader else {
                return UICollectionReusableView()
            }
            guard let section = self.viewModel?.sections?[indexPath.section] else { return UICollectionReusableView() }
            headerView.title?.text = section.title
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

extension SkillsViewController: SkillsViewModelOutput {
    func isLoading() {
        DispatchQueue.main.async {
            self.collectionView?.isHidden = true
            self.errorMessageLabel?.isHidden = true
            self.activityIndicatorView?.startAnimating()
        }
    }
    
    func didLoad() {
        if let _ = viewModel?.sections {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.collectionView?.isHidden = false
                self.activityIndicatorView?.stopAnimating()
            }
        } else {
            let errorMessage = viewModel?.errorMessage ?? "Error found!"
            DispatchQueue.main.async {
                self.errorMessageLabel?.text = errorMessage
                self.errorMessageLabel?.isHidden = false
                self.activityIndicatorView?.stopAnimating()
            }
        }
    }
}
