//
//  RecipeCustomCell.swift
//  CAPlusTDD
//
//  Created by richa.e.srivastava on 23/01/2022.
//

import UIKit

class RecipeCustomCell: UITableViewCell {

    static let identifier: String = "RecipeCustomCell"
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeImageView: LazyImageView!
    
    @IBOutlet weak var recipeCellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.updateSelectedState(isRecipeSelected: selected)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        recipeCellView.layer.cornerRadius = 10
        recipeCellView.layer.shadowColor = UIColor.lightGray.cgColor
        recipeCellView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        recipeCellView.layer.shadowRadius = 2.0
        recipeCellView.layer.shadowOpacity = 1.0
        recipeCellView.layer.masksToBounds = false
        recipeImageView.roundCorners([.topLeft, .topRight], radius: 10)
    }
    
    /// Configure cell with Recipe model
    /// - Parameter model: Recipe Model for each cell
    func configure(model: RecipeModelElement) {
        titleLabel.text = model.name
        subTitleLabel.text = model.headline
        prepTimeLabel.text = "\(model.preparationMinutes ?? 0) Min"
        guard let imgURL = URL(string: model.image ?? "") else {
            return
        }
        recipeImageView?.loadImage(imageURL: imgURL)
    }
    
    /// Update cell state for selected Cell
    /// - Parameter isRecipeSelected: flag for selected cell
    func updateSelectedState(isRecipeSelected: Bool) {
        if isRecipeSelected {
            recipeCellView.layer.borderColor = UIColor.green.cgColor
            recipeCellView.layer.borderWidth = 2
        } else {
            recipeCellView.layer.borderColor = UIColor.clear.cgColor
            recipeCellView.layer.borderWidth = 0
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeCellView.layer.borderColor = UIColor.clear.cgColor
        recipeCellView.layer.borderWidth = 0
    }
    
}
