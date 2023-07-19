//
//  ViewController.swift
//  IntegratorValidator
//
//  Created by Ankit on 31/05/20.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit
import ANValidator
import MyAppColorKit
import MyAppFontKit
import ANNetwork
import Combine
import ANAnimation

public extension Request {
    
    var baseUrl : String {
        return "https://jsonplaceholder.typicode.com/"
    }
     
    var reponseValidRange: ClosedRange<Int> {
        (200...399)
    }
}

struct Post: Codable {

    let id: Int
    let title: String
    let body: String
    let userId: Int
}

struct PostsRequest: RequestConvertable {
    
    typealias Response = [Post]
    typealias ResponseParser = GenericResponseParser<[Post]> //WeatherResponseParser
    
    var path: String = "posts"
    var method: String = "GET"
    var header: [String : String]?
    var parser: ResponseParser? = GenericResponseParser<[Post]>() //WeatherResponseParser()
    var errorParser: ErrorParserType? = DefaultErrorParser()
    
    
    
    func parameter() -> [String : Any]? {
        nil
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    var requestExecutor: RequestExecutor = WebApiClient()
    var subscribers = Set<AnyCancellable>()
    
    @Validate(validation: ValidationRule.username())
    var userName: String?
    
    @Validate(validation: ValidationRule.phoneNumber)
    var phoneNumber: String?
    
    @Validate(validation: ValidationRule.password)
    var password: String?
    
    @Validate(validation: ValidationRule.name)
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userName = nil
        if $userName.status {
            print("phone number = \($userName.status) - \($userName.statusMessage) - \(userName)")
        }else {
            print("\($userName.statusMessage)")
        }
        
        phoneNumber = "1234568890"
        if $phoneNumber.status {
            print("phone number = \($phoneNumber.status) - \($phoneNumber.statusMessage) - \(phoneNumber)")
        }else {
            print("\($phoneNumber.statusMessage)")
        }
        
        password = "1234568890"
        if $password.status {
            print("password  = \($password.status) - \($password.statusMessage) - \(password)")
        }else {
            print("\($password.statusMessage)")
        }
        
        name = nil
        if $name.status {
            print("name  = \($name.status) - \($name.statusMessage) - \(name)")
        }else {
            print("\($name.statusMessage)")
        }
        
        textLabel.textColor = MyAppColor.myAppBlue
        textLabel.font = MyAppFont.lightSmall
        
        ANAnimation.animateMyView(duration: 5.0) { [self] in
            
            textLabel.textColor = MyAppColor().moodColor(true)
            textLabel.font = MyAppFont.boldSmall
            
            textLabel.frame.origin.y += 200
        }
        
        requestExecutor.executeRequest(request: PostsRequest()).sink { completion in
            
            print("Thread == \(Thread.current)")
            switch completion {
            case .finished:
                print("receiveCompletion --> \(completion)")
            case .failure(let error):
                print("receiveCompletion \(error.localizedDescription)")
            }
        } receiveValue: { posts in
            print("Data -> \(posts)")
        }.store(in: &subscribers)

    }


}




extension ValidationRule where T == String {
    static var password : Self  {
        return self.regex("^(?=.*[0-9])(?=.*[A-Z]).{8,15}$", failedMessage: "Password should be min 8 max 15 char long, should contain one upper case char and a digit.")
    }
    
    static var name: Self {
        
        return .init{ value in
            print("VAlidation Value \(value)")
            return (true,"Success")
        }
    }
}
