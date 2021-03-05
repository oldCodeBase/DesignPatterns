import UIKit

/*
Шаги реализации:
1) Определите алгоритм, который подвержен частым изменениям.
   Также подойдёт алгоритм, имеющий несколько вариаций, которые выбираются во время выполнения программы.

2) Создайте интерфейс стратегий, описывающий этот алгоритм.
   Он должен быть общим для всех вариантов алгоритма.

3) Поместите вариации алгоритма в собственные классы, которые реализуют этот интерфейс.

4) В классе контекста создайте поле для хранения ссылки на текущий объект-стратегию, а также метод для её изменения.
   Убедитесь в том, что контекст работает с этим объектом только через общий интерфейс стратегий.

5) Клиенты контекста должны подавать в него соответствующий объект-стратегию, когда хотят, чтобы контекст вёл себя определённым образом.
*/

// First exemple

protocol FilterType {
    func process(image: UIImage) -> UIImage
}

class Filter {
    var filterType: FilterType?
    
    func applyFilter(to image: UIImage) {
        filterType?.process(image: image)
    }
}

class Sepia: FilterType {
    func process(image: UIImage) -> UIImage {
        print("Apply SEPIA filter to image")
        return image
    }
}

class Clarendon: FilterType {
    func process(image: UIImage) -> UIImage {
        print("Apply CLARENDON filter to image")
        return image
    }
}

class Mono: FilterType {
    func process(image: UIImage) -> UIImage {
        print("Apply MONO filter to image")
        return image
    }
}

let filter = Filter()
let image = UIImage()

filter.filterType = Sepia()
filter.applyFilter(to: image)

// Second exemple

protocol NavigationType {
    func navigate(a: String, b: String)
}

class Navigation {
    var navigationType: NavigationType?
    func builtRoute(from startPoint: String, to destination: String) {
        navigationType?.navigate(a: startPoint, b: destination)
    }
}

class BusNavigation: NavigationType {
    func navigate(a: String, b: String) {
        print("Bus route from \(a) to \(b)")
    }
}

class AirNavigation: NavigationType {
    func navigate(a: String, b: String) {
        print("Air route from \(a) to \(b)")
    }
}

class TrainNavigation: NavigationType {
    func navigate(a: String, b: String) {
        print("Train route from \(a) to \(b)")
    }
}

let navigation = Navigation()
navigation.navigationType = AirNavigation()
navigation.builtRoute(from: "New-York", to: "Moscow")

// Преимущества

/*
 Горячая замена алгоритмов на лету.
 Изолирует код и данные алгоритмов от остальных классов.
 Уход от наследования к делегированию.
 Реализует принцип открытости/закрытости.
*/

// Недостатки

/*
 Усложняет программу за счёт дополнительных классов.
 Клиент должен знать, в чём состоит разница между стратегиями, чтобы выбрать подходящую.
*/
