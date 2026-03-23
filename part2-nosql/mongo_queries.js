// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    "product_id": "ELEC-BAJ-001",
    "category": "Electronics",
    "name": "Bajaj Rex 500-Watt Mixer Grinder with 3 Jars",
    "brand": "Bajaj",
    "price": 3299.00,
    "description": "Durable kitchen mixer grinder with stainless steel jars, ideal for Indian cooking and grinding spices.",
    "specifications": {
      "warranty": "1 Year Manufacturer Warranty",
      "voltage_specs": "220-240V, 50Hz",
      "power_wattage": 500,
      "motor_type": "Copper Motor"
    },
    "included_components": [
      "1 Motor Unit",
      "1 Liquidizing Jar (1.2L)",
      "1 Dry Grinding Jar (0.8L)",
      "1 Chutney Jar (0.3L)"
    ]
  },
  {
    "product_id": "CLO-FAB-092",
    "category": "Clothing",
    "name": "Men's Handblock Print Cotton Kurta",
    "brand": "FabIndia",
    "price": 1899.00,
    "description": "Breathable pure cotton ethnic kurta featuring traditional Rajasthani handblock prints.",
    "material_info": {
      "fabric": "100% Cotton",
      "fit": "Regular Fit",
      "care_instructions": "Hand wash separately in cold water. Do not bleach. Dry in shade."
    },
    "available_variants": [
      { "size": "M", "color": "Indigo Blue", "stock_quantity": 12 },
      { "size": "L", "color": "Indigo Blue", "stock_quantity": 5 },
      { "size": "XL", "color": "Indigo Blue", "stock_quantity": 0 }
    ]
  },
  {
    "product_id": "GRO-AMU-500",
    "category": "Groceries",
    "name": "Amul Pure Cow Ghee - 1 Litre Pouch",
    "brand": "Amul",
    "price": 610.00,
    "stock_quantity": 150,
    "description": "Pure cow ghee with a rich aroma and granular texture, perfect for daily meals and sweets.",
    "grocery_details": {
      "expiry_date": "2024-12-31T23:59:59Z",
      "is_vegetarian": true,
      "nutritional_info_per_100g": {
        "energy_kcal": 814,
        "total_fat_g": 90.5,
        "saturated_fat_g": 58.0,
        "cholesterol_mg": 190,
        "protein_g": 0,
        "carbohydrates_g": 0
      }
    }
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
// Note: Even though our sample Bajaj mixer is cheaper, the query syntax remains correct.
db.products.find({ 
  category: "Electronics", 
  price: { $gt: 20000 } 
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({ 
  category: "Groceries", 
  "grocery_details.expiry_date": { $lt: "2025-01-01T00:00:00Z" } 
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { product_id: "CLO-FAB-092" },
  { $set: { discount_percent: 15 } }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });
/*
  Explanation: 
  Creating an index on the 'category' field improves read performance for queries filtering by category (like OP2 and OP3). 
  Without an index, MongoDB has to do a collection scan, checking every single document in the collection to see if the category matches. 
  With an index, the database can instantly locate the matching documents. This is critical for an e-commerce platform where users constantly browse specific categories.
*/