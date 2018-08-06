//
//  RxSwift+Extension.swift
//  TemplateProject
//
//  Created by TrungPhan on 7/4/18.
//  Copyright © 2018 Dwarvesv. All rights reserved.
//

import Foundation
import Foundation
import RxSwift
import RxCocoa

infix operator <->

@discardableResult func <-><T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    let variableToProperty = variable.asObservable()
        .bind(to: property)
    
    let propertyToVariable = property
        .subscribe(
            onNext: { variable.value = $0 },
            onCompleted: { variableToProperty.dispose() }
    )
    return Disposables.create(variableToProperty, propertyToVariable)
}
