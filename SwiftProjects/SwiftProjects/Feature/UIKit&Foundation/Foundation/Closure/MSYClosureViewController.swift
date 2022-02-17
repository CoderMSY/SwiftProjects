//
//  MSYClosureViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/2/5.
//  参考：https://juejin.cn/post/7053987682677948430

import UIKit
import RxSwift

class MSYClosureViewController: MSYBaseViewController {
    var handle: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCloseItem()
        
//        exampleClosure()
//        exampleClosureParam()
//        exampleTestTrailing()
//        exampleArray()
//        exampleFoo()
//        exampleEscaping()
        exampleAutoClosure()
    }
    
    

}

extension MSYClosureViewController {
    private func sum(_ a: Int, _ b: Int) -> Int { a + b }
    // MARK: 闭包
    /*
     { (param) -> (returnType) in
     //do something
     }
     */
    private func exampleClosure() {
        var c = 3
        let add = {
            (a: Int, b: Int) -> Int in
            return a + b + c
        }

        c = 5
        //调用时变量捕获
        let value = add(1, 2)
        print(value)
    }
//    private func exampleClosure() {
//        var c = 3
          // []，实现捕获列表capturing list，最初原始值的copy副本。
//        let add = {
//            [c] (a: Int, b: Int) -> Int in
//            return a + b + c
//        }
//
//        c = 5
//        let value = add(1, 2)
//        print(value)
//    }
    
    // MARK: Swift 中的闭包即可以当做变量，也可以当做参数传递。
    func testExample(param: () -> Int){
        print(param())
    }
    private func exampleClosureParam() {
        var testA = 10
        
        testExample(param: {
            () -> Int in
            testA += 5
            return testA
        })
    }
    
    // MARK: 尾随闭包
    func testTrailing(_ a: Int,
                      _ b: Int,
                      _ c: Int,
                      by: (_ item1: Int, _ item2: Int, _ item3: Int) -> Bool) -> Bool {
        return by(a, b, c)
    }
    private func exampleTestTrailing() {
        let value = testTrailing(10, 20, 30) { item1, item2, item3 in
            print("item1: ", item1);
            print("item2: ", item2);
            print("item3: ", item3);
            return item1 + item2 > item3
        }
        
        print("value: ", value);
    }
    
    // MARK: 闭包写法
    /*
     
     利用上下文推断参数和返回值类型
     单表达式可以隐式返回，既省略 return 关键字
     参数名称的简写（比如我们的 $0）
     尾随闭包表达式
     */
    private func exampleArray() {
        var array = [1, 2, 3]
//        array.sort { item1, item2 in
//            return item1 > item2
//        }
//        array.sort { a, b in
//            a > b
//        }
        array.sort(by: {
            (item1: Int, item2: Int) -> Bool in
            return item1 > item2
        })
        print("value: ", array)

        array.sort(by: {(item1 : Int, item2: Int) -> Bool in return item1 < item2 })

        array.sort(by: {(item1, item2) -> Bool in return item1 < item2 })

        array.sort(by: {(item1, item2) in return item1 < item2 })

        array.sort{(item1, item2) in item1 < item2 }

        array.sort{ return $0 < $1 }

        array.sort{ $0 < $1 }

        array.sort(by: <)
    }
    
    // MARK: defer 关键字用法
    private func exampleFoo() {
        defer {
            //defer block 里的代码会在函数 return 之前执行
            //如果多个 defer 语句出现在同一作用域中，它们执行的顺序和添加的顺序是相反的。
            print("finally")
        }
        defer {
            print("finally1")
        }
        
        do {
            throw NSError()
            print("impossible")
        } catch {
            print("handle error")
        }
    }
    
    // MARK: 逃逸闭包
    // 当闭包作为一个实际参数传递给一个函数的时候，并且是在函数返回之后调用，我们就说这个闭包逃逸了。
    private func exampleEscaping(_ a: Int, handler: @escaping (Int) -> Void) {
        self.handle = handler
    }
    private func exampleEscaping() {
        Closure().test(10) { a in
            print("escapint \(a)")
        }
    }
    class Closure{
        var handle: ((Int) -> Void)?

        func test(_ a: Int, handler: @escaping (Int) -> Void) {
            self.handle = handler
            handler(a)
        }
    }
    
    // MARK:自动闭包
    private func exampleAutoClosure() {
        var dataArr = ["a", "b", "c", "d", "e"]
//        print(dataArr.count)    // 打印出“5”
//
//        let removeStr = { dataArr.remove(at: 0) }
//        print(dataArr.count)    // 打印出“5”
//
//        print("debug \(removeStr())!") // Prints "debug a!"
//        print(dataArr.count)    // 打印出“4”
        
        serve(element: {
            dataArr.remove(at: 0)
        })
        
        serveAuto(element: dataArr.remove(at: 0))
//        serveAuto(element: {
//            dataArr.remove(at: 0)
//        })
    }
    
    // serve(element:) 函数接受一个返回元素的显式的闭包。
    private func serve(element elementProvider: () -> String) {
        print("debug \(elementProvider())!")
    }
    // 自动闭包
    private func serveAuto(element elementProvider: @autoclosure(() -> String)) {
        print("debug auto \(elementProvider())!")
    }

    // MARK: 闭包中的循环引用
    /**
     弱引用weak：一个变量可以选择不持有对其引用对象的拥有权。弱引用可以是空(nil)
     无主引用unowned：像弱引用，无主引用对引用对象不保持很强的关系。和弱引用不同的是，无主引用总是被设定为一个值。因此，无主引用总是被设定为不可选择的类型。无主引用不可以是空。
     */
    class Server {
        var clients : [Client] = []
        func add(client:Client){
            self.clients.append(client)
        }
    }

    class Client {
        weak var server : Server!
      
        init (server : Server) {
            self.server = server
            self.server.add(client:self)
        }
    }
}
