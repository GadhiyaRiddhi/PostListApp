//
//  PostDetail+CoreDataProperties.swift
//  
//
//  Created by keyur.tailor on 24/02/21.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var isFvrt: Bool

}
