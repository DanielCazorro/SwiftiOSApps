//
//  kcHerosClaseTests.swift
//  kcHerosClaseTests
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import XCTest
import SwiftUI
import Combine
import ViewInspector

@testable import kcHerosClase

final class kcHerosClaseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testModelos() throws {
        
        let model = Heros(id: UUID(), name: "Jose", description: "", photo: "", favorite: true)
        XCTAssertNotNil(model)
        XCTAssertEqual(model.name, "Jose")
        XCTAssertEqual(model.getFullName(), "Jose")
        
        let modelRequest = HerosFilter(name: "Goku")
        XCTAssertNotNil(modelRequest)
        XCTAssertEqual(modelRequest.name, "Goku")
    }

    func testUIViews() throws {
        let view = ErrorView(error: "Testing errorView")
            .environmentObject(RootViewModel(testing: true))
        XCTAssertNotNil(view)
        
        let numItems = try view.inspect().count
        XCTAssertEqual(numItems, 1)
        
        
        // Imagen
        let img = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(view)
        
        
        //Texto
        let text = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(text)
        
        let texto = try text.text().string()
        XCTAssertEqual(texto, "Testing errorView")
        
        
        // Botón
        let boton = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(boton)
        
        // Ejecutar el boton TAP
        try boton.button().tap() // Ejecuto el botón
        
        
        
    }
    
    func testViewModelBootCamps() throws {
        let expectation = self.expectation(description: "Descarga de bootcamps")
        var suscriptor = Set<AnyCancellable>()
        
        // Instancio el ViewModel
        let vm = RootViewModel(testing: true)
        XCTAssertNotNil(vm)
        
        // Creo el observador
        vm.bootcamps.publisher
            .sink { completion in
                switch completion {
                case .finished:
                    XCTAssertEqual(1, 1)
                    expectation.fulfill()
                case .failure:
                    XCTAssertEqual(1, 2)
                }
            } receiveValue: { data in
                XCTAssertEqual(1, 1) // Test OK
            }
            .store(in: &suscriptor)
        
        // Lanzamos la load
        vm.loadBootcampsTesting()
        
        // Esperamos los X segundos
        self.waitForExpectations(timeout: 10)
    }
    
    func testViewModelHeros() throws {
        let expectation = self.expectation(description: "Descarga de bootcamps")
        var suscriptor = Set<AnyCancellable>()
        
        // Instancio el ViewModel
        let vm = viewModelHeros(interactor: HerosInteractorFake())
        XCTAssertNotNil(vm)
        
        // Creo el observador
        vm.heros.publisher
            .sink { completion in
                switch completion {
                case .finished:
                    // OK
                    print("OK terminado la carga de heros")
                    
                case .failure:
                    XCTAssertEqual(1, 2) // Genero el fallo
                    expectation.fulfill()
                }
            } receiveValue: { heros in
                XCTAssertEqual(heros.count, 4) // Test OK
                expectation.fulfill()
            }
            .store(in: &suscriptor)
        
        // Esperamos los X segundos
        self.waitForExpectations(timeout: 10)
    }


}
