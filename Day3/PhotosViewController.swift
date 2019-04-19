//
//  PhotosViewController.swift
//  Day3
//
//  Created by Jessica Mallian on 4/18/19.
//  Copyright © 2019 Jessica Mallian. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchInterestingPhotos { (photosResult) in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
            }
        }
    }
}
