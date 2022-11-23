//
//  AccountList.swift
//  FinanceTracker
//
//  Created by Christophe on 24/10/2022.
//

import Foundation


class AccountsList: ObservableObject {
    
    @Published var accounts: [Account]
    init(accounts: [Account] = []) {
        self.accounts = accounts
    }
    
    static func load(completion: @escaping (Result<[Account], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async{
            do{
                let fileUrl = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileUrl) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let accounts = try JSONDecoder().decode([Account].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(accounts))
                }
                
            }catch{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(accounts: [Account], completion: @escaping (Result<Int, Error>) -> Void){
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(accounts)
                let outFile = try fileURL()
                try data.write(to: outFile)
                DispatchQueue.main.async {
                    completion(.success(accounts.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
   static private func fileURL() throws -> URL {
        let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let url = path.appendingPathComponent("accounts.data")
       print(url)
        return url
    }
    
    
}
