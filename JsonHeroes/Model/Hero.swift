//
//  Hero.swift
//  AutoChess
//
//  Created by devsenior on 16/06/2023.
//

import Foundation

struct Hero: Codable {
    let id: Int
    let name: String
    let avatarPosition: Position
    let avatar: String
    let ability: Ability
    let races: [String]
    let stats: [Stat]
    let statsMap: StatsMap
    let cost: String

}

// MARK: - Ability
struct Ability: Codable {
    let name, des, cooldown, image: String
    let position: Position
}

// MARK: - Position
struct Position: Codable {
    let x, y, w, h: Int
}

// MARK: - Stat
struct Stat: Codable {
    let name, des: String
    let value: [String]
}

// MARK: - StatsMap
struct StatsMap: Codable {
    let damage, hp, magicResistance, attackRate: [String]
    let averageDPS, armor: [String]

    enum CodingKeys: String, CodingKey {
        case damage = "Damage:"
        case hp = "HP:"
        case magicResistance = "Magic Resistance:"
        case attackRate = "Attack Rate:"
        case averageDPS = "Average DPS:"
        case armor = "Armor:"
    }
}



