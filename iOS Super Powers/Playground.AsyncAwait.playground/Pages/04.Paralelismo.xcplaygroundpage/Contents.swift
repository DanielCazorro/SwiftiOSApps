/*
 
 Paralelismo async let
 
 */

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


func loadImage(index: Int) async throws -> UIImage{
    
    let imageURL = URL(string: "https://i.blogs.es/f7b0ed/steve-jobs/1366_2000.jpg")!
    let request = URLRequest(url: imageURL)
    let (data,_) = try await URLSession.shared.data(for: request)
    print("Finalizada la carga de la imagen... \(index)")
    return UIImage(data: data)!
    
}

Task(priority: .medium) {
    async let firstImage = loadImage(index: 1)
    async let secondImage = loadImage(index: 2)
    async let thirdImage = loadImage(index: 3)
    
    print("Antes de llamar")
    
    let _ = try await [firstImage, secondImage, thirdImage]
    print("Despues, ya ejecutado")
    
}
