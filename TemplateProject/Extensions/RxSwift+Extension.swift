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

@discardableResult func <-><T: Equatable>(property: ControlProperty<T>, behaviorReplay: BehaviorRelay<T>) -> Disposable {
    let behaviorReplayToProperty = behaviorReplay.asObservable().distinctUntilChanged()
        .bind(to: property)
    
    let propertyToBehaviorReplay = property
        .subscribe(
            onNext: { behaviorReplay.accept($0)},
            onCompleted: { behaviorReplayToProperty.dispose() }
    )
    return Disposables.create(behaviorReplayToProperty, propertyToBehaviorReplay)
}

@discardableResult func <-><T>(property: ControlProperty<T>, publishSubject: PublishSubject<T>) -> Disposable {
    let publishSubjectToProperty = publishSubject.asObservable()
        .bind(to: property)
    
    let propertyToPublishSubject = property
        .subscribe(
            onNext: { publishSubject.onNext($0)},
            onCompleted: { publishSubjectToProperty.dispose() }
    )
    return Disposables.create(publishSubjectToProperty, propertyToPublishSubject)
}

@discardableResult func <-><T>(property: ControlProperty<T>, behaviorSubject: BehaviorSubject<T>) -> Disposable {
    let behaviorSubjectToProperty = behaviorSubject.asObservable()
        .bind(to: property)
    
    let propertyToBehaviorSubject = property
        .subscribe(
            onNext: { behaviorSubject.onNext($0)},
            onCompleted: { behaviorSubjectToProperty.dispose() }
    )
    return Disposables.create(behaviorSubjectToProperty, propertyToBehaviorSubject)
}

@discardableResult func <-><T>(property: ControlProperty<T>, replaySubject: ReplaySubject<T>) -> Disposable {
    let replaySubjectToProperty = replaySubject.asObservable()
        .bind(to: property)
    
    let propertyToReplaySubject = property
        .subscribe(
            onNext: { replaySubject.onNext($0)},
            onCompleted: { replaySubjectToProperty.dispose() }
    )
    return Disposables.create(replaySubjectToProperty, propertyToReplaySubject)
}
