//
//  CharacterListViewController.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import UIKit

final class CharacterListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let manager = NetworkManager()
        
        manager.getCharacters { result in
            switch result {
            case .success(let characters):
                print("Got characters: \(characters.count)")
            case .failure(let error):
                print("failed to get characters: \(error.localizedDescription)")
            }
        }
    }
}
