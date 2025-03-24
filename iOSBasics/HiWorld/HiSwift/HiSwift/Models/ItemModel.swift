//
//  ItemModel.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 17/3/25.
//

import Foundation

// MARK: - Data Model
struct ItemModel: Identifiable {
    let id = UUID()
    let emoji: String
    let name: String
    let description: String
}

// MARK: - Sample Data
let itemList: [ItemModel] = [
    .init(emoji: "🍎", name: "Apple", description: "A delicious red fruit."),
    .init(emoji: "🍊", name: "Orange", description: "A juicy citrus fruit."),
    .init(emoji: "🍋", name: "Lemon", description: "A sour yellow fruit."),
    .init(emoji: "🍌", name: "Banana", description: "A sweet tropical fruit."),
    .init(emoji: "🍇", name: "Grapes", description: "Small, juicy purple or green fruits."),
    .init(emoji: "🍓", name: "Strawberry", description: "A sweet red fruit with tiny seeds."),
    .init(emoji: "🍒", name: "Cherry", description: "A small, round, red fruit."),
    .init(emoji: "🍉", name: "Watermelon", description: "A refreshing summer fruit with a lot of water."),
    .init(emoji: "🍍", name: "Pineapple", description: "A tropical fruit with a spiky skin."),
    .init(emoji: "🥭", name: "Mango", description: "A juicy tropical fruit with a sweet flavor."),
    .init(emoji: "🥝", name: "Kiwi", description: "A small fruit with green flesh and brown skin."),
    .init(emoji: "🍑", name: "Peach", description: "A soft, fuzzy fruit with a sweet taste."),
    .init(emoji: "🥥", name: "Coconut", description: "A hard-shell tropical fruit with sweet white flesh."),
    .init(emoji: "🥕", name: "Carrot", description: "An orange vegetable that is crunchy and sweet."),
    .init(emoji: "🌽", name: "Corn", description: "A yellow grain vegetable often eaten on the cob."),
    .init(emoji: "🥒", name: "Cucumber", description: "A refreshing green vegetable."),
    .init(emoji: "🥬", name: "Lettuce", description: "A leafy green used in salads."),
    .init(emoji: "🥦", name: "Broccoli", description: "A green vegetable rich in nutrients."),
    .init(emoji: "🍆", name: "Eggplant", description: "A purple vegetable used in many cuisines."),
    .init(emoji: "🍄", name: "Mushroom", description: "An edible fungus with a unique texture."),
    .init(emoji: "🥔", name: "Potato", description: "A versatile starchy vegetable."),
    .init(emoji: "🧅", name: "Onion", description: "A pungent vegetable used in cooking."),
    .init(emoji: "🫑", name: "Bell Pepper", description: "A colorful vegetable with a sweet taste."),
    .init(emoji: "🫒", name: "Olive", description: "A small fruit used for oil and garnishes."),
    .init(emoji: "🥑", name: "Avocado", description: "A creamy green fruit used in salads and guacamole."),
    .init(emoji: "🍞", name: "Bread", description: "A staple food made from flour and water."),
    .init(emoji: "🥖", name: "Baguette", description: "A long, crispy French bread."),
    .init(emoji: "🧀", name: "Cheese", description: "A dairy product made from milk."),
    .init(emoji: "🥚", name: "Egg", description: "A protein-rich food from chickens."),
    .init(emoji: "🥩", name: "Steak", description: "A cut of beef cooked in various ways."),
    .init(emoji: "🍗", name: "Chicken Leg", description: "A roasted or fried piece of chicken."),
    .init(emoji: "🥓", name: "Bacon", description: "A crispy, salty pork product."),
    .init(emoji: "🍕", name: "Pizza", description: "A popular dish with cheese and toppings."),
    .init(emoji: "🌭", name: "Hot Dog", description: "A sausage in a bun with condiments."),
    .init(emoji: "🍔", name: "Burger", description: "A sandwich with meat, cheese, and vegetables."),
    .init(emoji: "🍟", name: "French Fries", description: "Fried potato sticks, often salted."),
    .init(emoji: "🍩", name: "Donut", description: "A sweet, fried pastry with a hole."),
    .init(emoji: "🍫", name: "Chocolate", description: "A sweet treat made from cocoa."),
    .init(emoji: "🍪", name: "Cookie", description: "A small baked sweet snack."),
    .init(emoji: "🍰", name: "Cake", description: "A sweet baked dessert for celebrations."),
    .init(emoji: "🥧", name: "Pie", description: "A baked dish with a pastry crust and filling."),
    .init(emoji: "🍦", name: "Ice Cream", description: "A frozen dessert made from cream and sugar."),
    .init(emoji: "🍧", name: "Sundae", description: "A dessert with ice cream and toppings."),
    .init(emoji: "🍨", name: "Frozen Yogurt", description: "A creamy frozen dessert made with yogurt."),
    .init(emoji: "🍯", name: "Honey", description: "A sweet substance made by bees."),
    .init(emoji: "🌰", name: "Chestnut", description: "A sweet, edible nut."),
    .init(emoji: "🥜", name: "Peanut", description: "A legume that is often roasted and salted."),
    .init(emoji: "🍚", name: "Rice", description: "A staple grain used in many cuisines."),
    .init(emoji: "🍝", name: "Pasta", description: "A type of noodle made from wheat."),
    .init(emoji: "🍜", name: "Noodles", description: "Long, thin strips of pasta served in broth."),
    .init(emoji: "🧄", name: "Garlic", description: "A strong-flavored bulb used in cooking."),
    .init(emoji: "🧂", name: "Salt", description: "A mineral used to enhance flavor."),
    .init(emoji: "🍋", name: "Lime", description: "A small, green citrus fruit."),
    .init(emoji: "🍊", name: "Tangerine", description: "A small citrus fruit with a sweet flavor."),
    .init(emoji: "🍏", name: "Green Apple", description: "A tart variety of apple."),
    .init(emoji: "🥭", name: "Passion Fruit", description: "A tropical fruit with a unique flavor."),
    .init(emoji: "🍐", name: "Pear", description: "A sweet fruit that is often juicy."),
    .init(emoji: "🍈", name: "Melon", description: "A sweet fruit with a high water content.")
]
