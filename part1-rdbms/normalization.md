## Anomaly Analysis

1. Insert Anomaly
**Example:** Since its based on Order ID, we cannot add/insert a product in a row, unless there is an order placed.
**Rows/Columns Cited:** cannot insert 'Product_nam' in G188 as there is no 'order_id' There is dependency present.

2. Update Anomaly
**Example:** Office addresses are duplicate, mentioned in multiple order rows, so missing on updating single row would cause anomaly or inconsistency. 
**Rows/Columns Cited:** I am trying to update Delhi office address in O2, but missed in O4, that will lead to 2 different address texts, for same Delhi office. So update in Column O(office_address) becomes critical to be right for all related rows

3. Delete Anomaly
**Example:** The product_name column (Column G) has all product names for which orders are placed. Considering that if a row related to product deletes and there is no other source of product information anywhere, that data is lost.
**Rows/Columns Cited:** G13 has product - Webcam, that's a single entry of order in entire sheet, while rest of the products have multiple lines. If I were to delete row 13, that order is lost, and there is no way to find if Webcam was ever in the Product list. This also loses Product ID (column F, product_id) because of the deletion.


## Normalization Justification

While keeping everything in one flat table looks simple at first glance, it is actually a ticking time bomb for data integrity, not over-engineering. If we stick to the flat CSV structure, we are forced to manage a massive amount of redundant data, which guarantees errors as the business scales.

Take our sales rep, Deepak Joshi, for instance. His name, email, and Mumbai HQ address are repeated across 83 separate rows in the original dataset. If his office moves or his email changes, someone has to manually update all 83 records. If they miss even one, our system suddenly has conflicting contact info for the exact same person. In our normalized SalesReps table, we only have to update his details in one place.

The flat table also makes it incredibly frustrating to manage our catalog. Let's say we want to stock a new model of a Standing Desk. In the flat file, every row requires an order_id. Because of this, we literally cannot add the new desk to our database until a customer actually buys it. 

Worse still is the risk of accidental data loss. The original dataset shows only one order (ORD1185) for the Webcam. If Amit Verma cancels that order and we delete the row to clear the transaction, we don't just lose the order -  we completely wipe out the Webcam's product ID, category, and price from our entire system. Normalization splits this data into distinct Products and Orders tables, meaning we can safely delete a transaction without destroying our product catalog. Breaking these entities apart isn't over-engineering; it's basic structural insurance for the company's data.