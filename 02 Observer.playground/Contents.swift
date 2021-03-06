import Foundation

/*
 Наблюдатель — это поведенческий паттерн проектирования, который создаёт механизм подписки,
 позволяющий одним объектам следить и реагировать на события, происходящие в других объектах.
*/

/*
 Шаги реализации:
 
 1) Разбейте вашу функциональность на две части: независимое ядро и опциональные зависимые части.
    Независимое ядро станет издателем. Зависимые части станут подписчиками.

 2) Создайте интерфейс подписчиков. Обычно в нём достаточно определить единственный метод оповещения.

 3) Создайте интерфейс издателей и опишите в нём операции управления подпиской.
    Помните, что издатель должен работать только с общим интерфейсом подписчиков.

 4) Вам нужно решить, куда поместить код ведения подписки, ведь он обычно бывает одинаков для всех типов издателей.
    Самый очевидный способ — вынести этот код в промежуточный абстрактный класс, от которого будут наследоваться все издатели.

    Но если вы интегрируете паттерн в существующие классы, то создать новый базовый класс может быть затруднительно.
    В этом случае вы можете поместить логику подписки во вспомогательный объект и делегировать ему работу из издателей.

 5) Создайте классы конкретных издателей.
    Реализуйте их так, чтобы после каждого изменения состояния они отправляли оповещения всем своим подписчикам.

 6) Реализуйте метод оповещения в конкретных подписчиках.
    Не забудьте предусмотреть параметры, через которые издатель мог бы отправлять какие-то данные, связанные с происшедшим событием.

    Возможен и другой вариант, когда подписчик, получив оповещение, сам возьмёт из объекта издателя нужные данные.
    Но в этом случае вы будете вынуждены привязать класс подписчика к конкретному классу издателя.

 7) Клиент должен создавать необходимое количество объектов подписчиков и подписывать их у издателей.
*/

// Exemple

protocol Observable {
    func add(observer: Observer)
    func remove(observer: Observer)
    func notifyObservers()
}

protocol Observer {
    var id: String { get set}
    func update(value: Int?)
}

class NewsResource: Observable {
    
    var value: Int? {
        didSet {
            notifyObservers()
        }
    }
    
    private var observers: [Observer] = []
    
    func add(observer: Observer) {
        observers.append(observer)
    }
    
    func remove(observer: Observer) {
        guard let index = observers.enumerated().first(where: { $0.element.id == observer.id })?.offset else { return }
        observers.remove(at: index)
    }
    
    func notifyObservers() {
        observers.forEach({ $0.update(value: value )})
    }
}

class NewAgency: Observer {
    var id = "newsAgency"
    
    func update(value: Int?) {
        guard let value = value else { return }
        print("News Agency handle updated value: \(value)")
    }
}

class Reporter: Observer {
    var id = "reporter"
    
    func update(value: Int?) {
        guard let value = value else { return }
        print("Reporter updated value: \(value)")
    }
}

class Blogger: Observer {
    var id = "blogger"
    
    func update(value: Int?) {
        guard let value = value else { return }
        print("Blogger. New article about value: \(value)")
    }
}

let resource = NewsResource()
let newsAgency = NewAgency()
let reporter = Reporter()
let blogger = Blogger()

resource.add(observer: newsAgency)
resource.add(observer: reporter)

resource.value = 5

resource.add(observer: blogger)
resource.value = 3

resource.remove(observer: reporter)
resource.value = 7

//Преимущества

/*
 Издатели не зависят от конкретных классов подписчиков и наоборот.
 Вы можете подписывать и отписывать получателей на лету.
 Реализует принцип открытости/закрытости.
*/

//Недостатки

/*
 Подписчики оповещаются в случайном порядке.
*/

