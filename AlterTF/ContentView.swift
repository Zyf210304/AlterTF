//
//  ContentView.swift
//  AlterTF
//
//  Created by 张亚飞 on 2022/4/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Button("Present Alert") {
            
            alertTF(title: "Login", message: "Please enter your password for @luffy", hintText: "123456", primaryTitle: "Login", secondaryTitle: "Cancle") { String in
                
                print(String)
            } secondaryAction: {
                print("Canceled")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    
    //Mark: Alert TF
    func alertTF(title: String, message: String, hintText:String, primaryTitle: String, secondaryTitle: String, primaryAction:@escaping(String)->(), secondaryAction: @escaping()->()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { field in
            
            field.placeholder = hintText
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            
            secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            
            if let text = alert.textFields?[0].text {
                
                primaryAction(text)
            } else {
                
                primaryAction("")
            }
        }))
        
        //MARK: Presenting Alert
        rootController().present(alert, animated: true, completion: nil)
        
    }
    
    //MARK ROOT View Controller
    func rootController() -> UIViewController {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            
            return .init()
        }
        
        return root
    }
}
