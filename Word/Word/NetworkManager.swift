//
//  NetworkManager.swift
//  New Word
//
//  Created by Арайлым Кабыкенова on 17.12.2025.
//
import Foundation

protocol WordManagerDelegate:AnyObject{
    func didUpdateWord(_ wordManager:NetworkManager,_ recievedData:RecievedData)
    func didCheckSynonym()
}

protocol SynonymCheckManager:AnyObject{
    func didCheckSynonym(_ synonymCheckManager:NetworkManager,_ recievedData:AnswerCheckData)
}


enum Endpoint{
    case getWord
    case check
}


class NetworkManager{
    weak var delegate2:SynonymCheckManager?
    weak var delegate:WordManagerDelegate?
    //http://localhost:8000/api/v1/
    //http://172.20.10.3:8000/api/v1/
    let baseUrl="http://localhost:8000/api/v1/"
    
    func fetchData<T: Codable>(endpoint:Endpoint,requestData: T){
        let urlString:String
        switch endpoint{
        case .getWord:
            urlString="\(baseUrl)getWord"
        case .check:
            urlString="\(baseUrl)check"
        }
        performRequest(with : urlString, endpoint: endpoint, requestData)
        
    }
    func performRequest<T: Codable>(with urlString:String,endpoint:Endpoint,_ requestData: T){
        guard let url = URL(string: urlString) else { return }
            var urlRequest=URLRequest(url:url)
        urlRequest.httpMethod="POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            urlRequest.httpBody=try JSONEncoder().encode(requestData)
        }catch{
            print("Failed to encode JSON")
            return
        }
            let urlSession=URLSession(configuration:.default)
            let task=urlSession.dataTask(with:urlRequest){data,response,error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData=data{
                    switch endpoint{
                    case .getWord:
                        if let recievedWord=self.parseWordJSON(safeData){
                            DispatchQueue.main.async {
                                self.delegate?.didUpdateWord(self,recievedWord)
                                self.delegate?.didCheckSynonym()
                            }
                        }
                    case .check:
                        if let answerBool=self.parseAnswerJSON(safeData){
                            DispatchQueue.main.async{
                                self.delegate2?.didCheckSynonym(self, answerBool)
                            }
                        }
                }
            }
            
            
        }
        task.resume()
    }
    
    
    func parseWordJSON(_ data:Data)->RecievedData?{
        let decoder=JSONDecoder()
        do{
            let decodedData=try decoder.decode(RecievedData.self, from: data)
            return decodedData
        }catch{
            print(error)
            return nil
        }
    }
    
    func parseAnswerJSON(_ data:Data)->AnswerCheckData?{
        do{
            let decodedData=try JSONDecoder().decode(AnswerCheckData.self,from:data)
            return decodedData
        }
        catch{
            print(error)
            return nil
        }
    }
}
