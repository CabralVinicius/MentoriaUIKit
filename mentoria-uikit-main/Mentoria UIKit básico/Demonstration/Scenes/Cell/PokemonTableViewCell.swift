import UIKit

class PokemonTableViewCell: UITableViewCell {
    static let identifier = "PokemonCell"

    private let spriteImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()

    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()

    // Opcional: um label para tipos
    private let typesLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        lbl.textColor = .darkGray
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(spriteImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(typesLabel)

        NSLayoutConstraint.activate([
            spriteImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            spriteImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            spriteImageView.widthAnchor.constraint(equalToConstant: 48),
            spriteImageView.heightAnchor.constraint(equalToConstant: 48),

            nameLabel.leadingAnchor.constraint(equalTo: spriteImageView.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            typesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            typesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            typesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            typesLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    override func prepareForReuse() {
        super.prepareForReuse()
        spriteImageView.image = nil
        nameLabel.text = nil
        typesLabel.text = nil
    }

    func configure(with detail: PokemonDetail) {
        hideSkeleton()
        nameLabel.text = detail.name.capitalized
        typesLabel.text = detail.types
            .sorted { $0.slot < $1.slot }
            .map { $0.type.name.capitalized }
            .joined(separator: " • ")
        
        // Carregamento simples de imagem (em prod, use cache ou Kingfisher/SDWebImage)
        if let url = detail.sprites.front_default {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let d = data, let img = UIImage(data: d) else { return }
                DispatchQueue.main.async {
                    self.spriteImageView.image = img
                }
            }.resume()
        }
    }
}


extension PokemonTableViewCell {
    func showSkeleton() {
        spriteImageView.isHidden = true
        nameLabel.isHidden = true
        typesLabel.isHidden = true

        contentView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        contentView.startShimmering()
    }

    func hideSkeleton() {
        contentView.stopShimmering()
        contentView.backgroundColor = .white
        spriteImageView.isHidden = false
        nameLabel.isHidden = false
        typesLabel.isHidden = false
    }
}
