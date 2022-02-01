//
//  RecipeViewControllerTest.swift
//  CAPlusTDDTests
//
//  Created by richa.e.srivastava on 23/01/2022.
//

import Foundation
import XCTest
@testable import CAPlusTDD

class RecipesViewControllerTest: XCTestCase {

    func test_viewDidLoad_setTitle() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "Hello Fresh")
    }
    
    func test_recipeViewModel_mustNotBeNil() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.recipeViewModel)
    }
    func test_tableview_datasource_mustNotbeNil() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView?.dataSource)
    }
    
    func test_recipeTableview_initialState() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView?.numberOfRows(inSection: 0), 0)
    }
    
    func test_recipeViewModel_getAPIData_Method_Called() throws {
        let sut = try makeSUT()
        let mockRecipeViewModel = sut.recipeViewModel as? MockRecipeViewModel
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(mockRecipeViewModel?.getAPIDataMethodCalled, true)
    }
    
    func test_recipeViewModel_getDataFromAPI_renderSuccessResponse() throws {
        let sut = try makeSUT()
        let mockRecipeViewModel = sut.recipeViewModel as? MockRecipeViewModel
        mockRecipeViewModel?.shouldReturnResponse = true
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView?.numberOfRows(inSection: 0), 1)
    }
    
    
    func test_recipeViewModel_getDataFromAPI_renderError() throws {
        let sut = try makeSUT()
        let mockRecipeViewModel = sut.recipeViewModel as? MockRecipeViewModel
        mockRecipeViewModel?.shouldReturnResponse = true
        mockRecipeViewModel?.shouldReturnError = true
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView?.numberOfRows(inSection: 0), 0)
        XCTAssertNotNil(sut.errorAlertController)
        XCTAssertEqual(sut.errorAlertController?.title, "Error")
        XCTAssertEqual(sut.errorAlertController?.message, NetworkErrorType.failed.rawValue)
        XCTAssertNotNil(sut.errorAlertController?.actions)
        XCTAssertEqual(sut.errorAlertController?.actions.count, 1)
        XCTAssertEqual(sut.errorAlertController?.actions.first?.title, "Ok")
    }
    
    func test_tableviewCell_selectedCell_MustBeHighLightedWithGreenBorder() throws {
        let sut = try makeSUT()
        let mockRecipeViewModel = sut.recipeViewModel as? MockRecipeViewModel
        mockRecipeViewModel?.shouldReturnResponse = true
        sut.loadViewIfNeeded()
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView?.cellForRow(at: indexPath) as? RecipeCustomCell
        sut.tableView?.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
        XCTAssertEqual(cell?.recipeCellView.layer.borderColor, UIColor.green.cgColor)
        XCTAssertEqual(cell?.recipeCellView.layer.borderWidth, 2)
    }
    
    func test_tableviewCell_unSelectedCell_MustNotBeHighLightedWithBorder() throws {
        let sut = try makeSUT()
        let mockRecipeViewModel = sut.recipeViewModel as? MockRecipeViewModel
        mockRecipeViewModel?.shouldReturnResponse = true
        sut.loadViewIfNeeded()
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView?.cellForRow(at: indexPath) as? RecipeCustomCell
        sut.tableView?.deselectRow(at: indexPath, animated: false)
        
        XCTAssertEqual(cell?.recipeCellView.layer.borderColor, UIColor.clear.cgColor)
        XCTAssertEqual(cell?.recipeCellView.layer.borderWidth, 0)
    }
    
    
    // MARK: Create Subject under test
    func makeSUT() throws -> RecipesViewController {
        let bundle = Bundle(for: RecipesViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let initialVC = storyboard.instantiateInitialViewController()
        let navigation = try XCTUnwrap(initialVC as? UINavigationController)
        let recipeViewController = navigation.topViewController as? RecipesViewController
        recipeViewController?.recipeViewModel = MockRecipeViewModel(shouldReturnError: false)
        return try XCTUnwrap(recipeViewController)
    }
}
