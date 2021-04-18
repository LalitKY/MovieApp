//
//  MovieData+CoreDataProperties.swift
//  
//
//  Created by Lalit Kant on 18/04/21.
//
//

import Foundation
import CoreData


extension MovieData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieData> {
        return NSFetchRequest<MovieData>(entityName: "MovieData")
    }

    @NSManaged public var cache_time_out: Date?
    @NSManaged public var is_favourited: Bool
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var page: Int64
    @NSManaged public var poster_path: String?
    @NSManaged public var total_pages: Int64
    @NSManaged public var total_results: Int64
    @NSManaged public var id: Int64

}
