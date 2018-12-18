//
//  AlamofireManager.swift
//  BrewBound
//
//  Created by Nitin Bansal on 20/05/17.
//  Copyright © 2017 Nitin Bansal. All rights reserved.
//

import UIKit
import Alamofire
class AlamofireManager: NSObject {
    var httpRequest : HttpObject!
    var restDelegate : RestDelegate!
    init(httpRequest : HttpObject, restDelegate : RestDelegate) {
        self.httpRequest = httpRequest;
        self.restDelegate = restDelegate;
    }
    
    func startDownload(){
        restDelegate.onPreExecute(httpRequestObject: httpRequest, forTaskCode: httpRequest.strtaskCode)
        switch httpRequest.methodType {
        case METHODS.GET:
            getData()
            break;
        case METHODS.PUT:
            putData()
            break;
        case METHODS.DELETE:
            deleteData()
            break;
        case METHODS.POST:
            postData()
            break;
        case .PATCH:
            patchData()
            break;
        case .FILE_UPLOAD:
            uploadFileReq()
            break
        }
    }
    
    func getData(){
        let dataRequest : DataRequest = Alamofire.request(httpRequest.strUrl, method: .get, parameters: httpRequest.params, encoding: URLEncoding.default, headers: httpRequest.headers)
        dataRequest.validate(statusCode: 200..<501).responseString {response in
            print("result:\(response.result.isSuccess)")
            print("value:\(String(describing: response.result.value))")
            switch response.result{
            case .success:
                self.onSuccessResponse(response: response);
                break
            case .failure:
                self.onFailureResponse(response: response);
                break
            }
        }
    }
    
    func onSuccessResponse(response : DataResponse<String>){
        print("SuccessData:\(String(describing: response.result.value))");
        let httpResponse = HttpResponse();
        httpResponse.responseObject = JsonParser.parseJson(taskCode: httpRequest.strtaskCode, response: response);
        httpResponse.responseResult = HttpResponseResult.SUCCESS;
        let flag = self.restDelegate.onSuccess(httpResponse, forTaskCode: httpRequest.strtaskCode, httpRequestObject: httpRequest);
        print("Success:\(flag)");
    }
    
    func onFailureResponse(response : DataResponse<String>){
        print("FailureData:\(String(describing: response.result.value))");
        var string = String.init(data: response.data!, encoding: .utf8)
        let httpResponse = HttpResponse();
        if response.result.isFailure{
            string = "{\"error\":true,\"message\":\"Request timed out\"}"
        }
        let r = BaseResponse(JSONString : string!)!
        httpResponse.responseObject = r;
        print(string!)
        httpResponse.responseResult = HttpResponseResult.FAILURE;
        self.restDelegate.onFailure(httpResponse, forTaskCode: httpRequest.strtaskCode)
    }
    
    
    func postData(){
        let dataRequest : DataRequest = Alamofire.request(httpRequest.strUrl, method: .post, parameters: httpRequest.params, encoding: JSONEncoding.default, headers: httpRequest.headers)
        dataRequest.validate(statusCode: 200..<300).responseString {response in
            print("result:\(response.result.isSuccess)")
            print("value:\(String(describing: response.result.value))")
            switch response.result{
            case .success:
                self.onSuccessResponse(response: response);
                break
            case .failure:
                self.onFailureResponse(response: response);
                break
                
            }
        }
    }
    
    func patchData(){
        let dataRequest : DataRequest = Alamofire.request(httpRequest.strUrl, method: .patch, parameters: httpRequest.params, encoding: JSONEncoding.default, headers: httpRequest.headers)
        dataRequest.validate(statusCode: 200..<300).responseString {response in
            print("result:\(response.result.isSuccess)")
            print("value:\(String(describing: response.result.value))")
            switch response.result{
            case .success:
                self.onSuccessResponse(response: response);
                break
            case .failure:
                self.onFailureResponse(response: response);
                break
                
            }
        }
    }
    
    func uploadFileReq(){
        if let fileRequest = httpRequest.fileRequest{
            uploadImageData(imgData: fileRequest.data!, keyName: fileRequest.keyName, fileName: fileRequest.fileName, mimeType: fileRequest.mimeType)
        }
    }
    
    func uploadImageData(imgData : Data, keyName : String, fileName : String, mimeType : String){
        var formData = MultipartFormData.init()
        formData.append(imgData, withName: keyName, fileName: fileName, mimeType: mimeType);
        for (key, value) in self.httpRequest.params {
            formData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
        }

        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: keyName,fileName: fileName, mimeType: mimeType)
            for (key, value) in self.httpRequest.params {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        },
                         to:self.httpRequest.strUrl, method: .post, headers : self.httpRequest.headers)
        { (result) in
            switch result {
            case .success(let upload, _, _):

                upload.responseJSON { response in
                    print("value:\(String(describing: response.result.value))")
                    if response.result.isSuccess{
                        let httpResponse = HttpResponse();
                        let map = response.result.value as! [String:Any]
                        httpResponse.responseObject = FileUploadResponse(JSON: map)
                        let flag = self.restDelegate.onSuccess(httpResponse, forTaskCode: self.httpRequest.strtaskCode, httpRequestObject: self.httpRequest)
                        print(flag)
                    }else{
                        let httpResponse = HttpResponse();
                        self.restDelegate.onFailure(httpResponse, forTaskCode:self.httpRequest.strtaskCode)
                    }

                }

            case .failure(let encodingError):
                print(encodingError)
                let httpResponse = HttpResponse();
                self.restDelegate.onFailure(httpResponse, forTaskCode:self.httpRequest.strtaskCode)

            }
        }
    }
    
    func deleteData(){
        performServerRequest(.delete)
    }
    
    
    func performServerRequest(_ method : HTTPMethod){
        let dataRequest : DataRequest = Alamofire.request(httpRequest.strUrl, method: method, parameters: httpRequest.params, encoding: JSONEncoding.default, headers: httpRequest.headers)
        dataRequest.validate(statusCode: 200..<300).responseString {response in
            print("result:\(response.result.isSuccess)")
            print("value:\(response.result.value)")
            switch response.result{
            case .success:
                self.onSuccessResponse(response: response);
                break
            case .failure:
                self.onFailureResponse(response: response);
                break
                
            }
        }
    }
    
    func putData(){
        performServerRequest(.put)
    }
}
