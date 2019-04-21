//
//  PhotosViewController.swift
//  Day3
//
//  Created by Jessica Mallian on 4/18/19.
//  Copyright © 2019 Jessica Mallian. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchInterestingPhotos { (photosResult) in
            switch photosResult {
            case let .success(photos):
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        //download the image data, which could take some time
        store.fetchImage(for: photo) { (result) in
            // the index path for the photo migh thave changed between the time the request started and finfished, so find the most recent index path
            guard let photoIndex = self.photoDataSource.photos.index(of: photo), case let .success(image) = result else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            // when the request finishes, only update the cell if it is still visible
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
        }
    }
}
