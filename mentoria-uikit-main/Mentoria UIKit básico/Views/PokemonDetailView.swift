import UIKit

class PokemonDetailView: UIView {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let statsLabel = UILabel()
    let typesLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        let stack = UIStackView(arrangedSubviews: [
            imageView, nameLabel, typesLabel, statsLabel
        ])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true

        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        typesLabel.font = .systemFont(ofSize: 16, weight: .medium)
        statsLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statsLabel.numberOfLines = 0
        statsLabel.textAlignment = .center
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with p: PokemonDetail) {
        nameLabel.text = "#\(p.id)  \(p.name.capitalized)"
        typesLabel.text = p.types
            .sorted { $0.slot < $1.slot }
            .map { $0.type.name.capitalized }
            .joined(separator: " • ")
        statsLabel.text = """
        Altura: \(p.height)
        Peso: \(p.weight)
        """
        if let url = p.sprites.front_default {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let d = data, let img = UIImage(data: d) else { return }
                DispatchQueue.main.async {
                    self.imageView.image = img
                }
            }.resume()
        }
    }
}
