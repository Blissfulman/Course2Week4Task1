//
//  RadioViewController.swift
//  Course2Week4Task1
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class RadioViewController: UIViewController {
    
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()

    private lazy var nameOfSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Aerosmith - Hole In My Soul"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var albumImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "albumImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var progress: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progress = 0.5
        return progress
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.value = 0.5
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        layoutTrait(traitCollection: traitCollection)
    }
    
    private func setupUI() {
        view.addSubview(albumImage)
        view.addSubview(progress)
        view.addSubview(slider)
        view.addSubview(nameOfSongLabel)
    }
    
    private func setupConstraints() {
        // Общие констрейнты
        sharedConstraints.append(contentsOf: [
            // Для изображения
            NSLayoutConstraint(item: albumImage,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: albumImage,
                               attribute: .height,
                               multiplier: 1,
                               constant: 1),
            albumImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            // Для прогресса
            progress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            progress.heightAnchor.constraint(equalToConstant: 2),
            // Для слайдера
            slider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            slider.heightAnchor.constraint(equalToConstant: 31),
            // Для названия трека
            nameOfSongLabel.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 0),
            nameOfSongLabel.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: 0)
        ])
        
        // Констрейнты для compact представления по горизонтали
        compactConstraints.append(contentsOf: [
            // Для изображения
            albumImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            albumImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            albumImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            // Для прогресса
            progress.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 30),
            // Для названия трека
            nameOfSongLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0.0)
        ])
        
        // Констрейнты для regular представления по горизонтали
        regularConstraints.append(contentsOf: [
            // Для изображения
            albumImage.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 16),
            albumImage.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -16),
            // Для прогресса
            progress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            // Для названия трека
            nameOfSongLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 16),
            nameOfSongLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func layoutTrait(traitCollection: UITraitCollection) {
        NSLayoutConstraint.activate(sharedConstraints)
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
}
