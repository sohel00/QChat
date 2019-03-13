//
//  CollectionReference.swift
//  QChat
//
//  Created by Sohel Dhengre on 13/03/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Typing
    case Recent
    case Message
    case Group
    case Call
}


func reference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}

