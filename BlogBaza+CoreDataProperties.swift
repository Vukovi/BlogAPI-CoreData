//
//  BlogBaza+CoreDataProperties.swift
//  Blog
//
//  Created by Vuk on 7/15/16.
//  Copyright © 2016 User. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension BlogBaza {

    @NSManaged var naslov: String?
    @NSManaged var autor: String?
    @NSManaged var objava: String?
    @NSManaged var fotografija: String?
    @NSManaged var sadrzaj: String?

}
