import UIKit

/*
 Декоратор — это структурный паттерн проектирования, который позволяет динамически
 добавлять объектам новую функциональность, оборачивая их в полезные «обёртки».
*/

/*
 Шаги реализации

 1) Убедитесь, что в вашей задаче есть один основной компонент и несколько опциональных дополнений или надстроек над ним.

 2) Создайте интерфейс компонента, который описывал бы общие методы как для основного компонента, так и для его дополнений.

 3) Создайте класс конкретного компонента и поместите в него основную бизнес-логику.

 4) Создайте базовый класс декораторов. Он должен иметь поле для хранения ссылки на вложенный объект-компонент.
    Все методы базового декоратора должны делегировать действие вложенному объекту.

 5) И конкретный компонент, и базовый декоратор должны следовать одному и тому же интерфейсу компонента.

 6) Теперь создайте классы конкретных декораторов, наследуя их от базового декоратора.
    Конкретный декоратор должен выполнять свою добавочную функцию, а затем (или перед этим) вызывать эту же операцию обёрнутого объекта.

 7) Клиент берёт на себя ответственность за конфигурацию и порядок обёртывания объектов.
*/

// Exemple

protocol Coffee {
    func cost() -> Double
    func ingredients() -> String
}

class Espresso: Coffee {
    
    func ingredients() -> String {
        return "Espresso"
    }
    
    func cost() -> Double {
        return 100
    }
}

class CoffeeDecorator: Coffee {
    
    private var coffee: Coffee
    
    init(coffee: Coffee) {
        self.coffee = coffee
    }
    
    func ingredients() -> String {
        return coffee.ingredients()
    }
    
    func cost() -> Double {
        return coffee.cost()
    }
}

class Milk: CoffeeDecorator {
    
    override func ingredients() -> String {
        return super.ingredients() + ", Milk"
    }
    
    override func cost() -> Double {
        return super.cost() + 20
    }
}

class Whip: CoffeeDecorator {
    
    override func ingredients() -> String {
        return super.ingredients() + ", Whip"
    }
    
    override func cost() -> Double {
        return super.cost() + 30
    }
}

class Chocolate: CoffeeDecorator {
    
    override func ingredients() -> String {
        return super.ingredients() + ", Chocolate"
    }
    
    override func cost() -> Double {
        return super.cost() + 50
    }
}

let espresso                = Espresso()
let cappuccino              = Whip(coffee: Milk(coffee: espresso))
let cappuccinoWithChocolate = Chocolate(coffee: cappuccino)

print(espresso.ingredients())
print(espresso.cost())

print(cappuccino.ingredients())
print(cappuccino.cost())

print(cappuccinoWithChocolate.ingredients())
print(cappuccinoWithChocolate.cost())

// Second Exemple

protocol Screen {
    var view: UIView { get }
    var colour: UIColor { get }
}

class MainView: Screen {
    var view: UIView
    var colour: UIColor
    
    init(view: UIView, colour: UIColor) {
        self.view = view
        self.view.backgroundColor = colour
        self.colour = colour
    }
}

class Decorator: Screen {
    var view: UIView
    var colour: UIColor
    
    init(screen: Screen) {
        self.view = screen.view
        self.colour = screen.colour
    }
}

class AddBorder: Decorator {
    override init(screen: Screen) {
        super.init(screen: screen)
        self.view.layer.borderColor = UIColor.black.cgColor
        self.view.layer.borderWidth = 6
    }
}

class AddImage: Decorator {
    override init(screen: Screen) {
        super.init(screen: screen)
        addImage()
    }
    
    func addImage() {
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .center
            imageView.image = UIImage(systemName: "paperplane.circle.fill")
            return imageView
        }()
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

var mainView: Screen = MainView(view: UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200)), colour: .systemRed)
                                
mainView = AddBorder(screen: mainView)

mainView = AddImage(screen: mainView)

// Преимущества

/*
  Большая гибкость, чем у наследования.
  Позволяет добавлять обязанности на лету.
  Можно добавлять несколько новых обязанностей сразу.
  Позволяет иметь несколько мелких объектов вместо одного объекта на все случаи жизни.
*/

// Недостатки

/*
 Трудно конфигурировать многократно обёрнутые объекты.
 Обилие крошечных классов.
*/
