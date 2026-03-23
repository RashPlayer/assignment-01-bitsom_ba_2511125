## Storage Systems

Instead of forcing all data into a single system, I used a persistence approach, matching specific databases to their ideal workloads:

1. MySQL (Relational) for Transactions: I chose MySQL for core operations like user checkouts and payment processing. Relational databases enforce strict ACID rules. This guarantees that when an order is placed (like the transactions we saw for "Smartwatches" or "Laptops"), the inventory and billing update reliably without partial failures or ghost records.

2. MongoDB (NoSQL) for the Catalog: Our product catalog is highly varied. For example, "Atta 10kg" needs an expiry date, while a "Speaker" needs voltage specifications. MongoDB's document model allows us to store these completely different attributes in the same collection without creating dozens of empty, unused columns in a traditional SQL table.

3. Data Warehouse (Star Schema) for Analytics: To run complex reports, I designed a separate Data Warehouse. As we saw in the SQL portion, setting up a central fact_sales table linked to dimension tables makes it much faster to calculate things like month-over-month revenue without straining the main database.

4. Vector Database for AI Search: Traditional databases only find exact word matches. A vector database stores text as mathematical embeddings. This is necessary for the AI features (like searching 500-page contracts or letting users search for "warm winter wear" and returning a "Jacket") because it matches the actual meaning of the query, not just the keywrods.


## OLTP vs OLAP Boundary

In this architecture, the boundary between the transactional system (OLTP) and the analytical system (OLAP) is the ETL pipeline.

The OLTP side includes the live MySQL and MongoDB databases. These systems face the customer and handle rapid, single-row updates (like adding an item to a cart).

The OLAP side is the Data Warehouse. The live website never directly queries the warehouse. Instead, the ETL pipeline acts as the gatekeeper. It periodically extracts data from the live systems, cleans it (for example, standardizing the messy DD/MM/YYYY dates from our raw CSV), and loads it into the warehouse. This strict separation ensures that a manager running a massive yearly sales report won't cause the website to lag for a customer trying to check out.


## Trade-offs
The main trade-off of separating the Data Warehouse from the live databases is data latency. Because data relies on the ETL pipeline to move across the boundary, the analytical dashboards are not truly real-time. If the ETL job only runs nightly, business analysts are always looking at data that is up to 24 hours old.

To mitigate this without hurting system performance, we could implement Change Data Capture (CDC). A CDC tool monitors the transaction logs in MySQL and streams those changes directly into the Data Warehouse within seconds, keeping the reporting dashboards fresh without bogging down the live application.