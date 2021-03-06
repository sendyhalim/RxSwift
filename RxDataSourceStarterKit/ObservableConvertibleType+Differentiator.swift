//
//  ObservableConvertibleType+Differentiator.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 11/14/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

extension ObservableConvertibleType where E: SequenceType, E.Generator.Element : protocol<SectionModelType, Hashable>, E.Generator.Element.Item: Hashable {
    typealias Section = E.Generator.Element

    func differentiateForSectionedView()
        -> Observable<[Changeset<Section>]> {

        return self.asObservable().multicast({
            return PublishSubject()
        }) { (sharedSource: Observable<E>) in
            let newValues = sharedSource.skip(1)

            let initialValueSequence: Observable<[Changeset<Section>]>= sharedSource
                .take(1)
                .map { [Changeset.initialValue(Array($0))] }

            let differences = zip(sharedSource, newValues) { oldSections, newSections -> [Changeset<Section>] in
                do {
                    return try differencesForSectionedView(Array(oldSections), finalSections: Array(newSections))
                }
                // in case of error, print it to terminal only
                catch let e {
                    print(e)
                    return [Changeset.initialValue(Array(newSections))]
                }
            }

            return sequenceOf(initialValueSequence, differences).merge()
        }
    }
}
