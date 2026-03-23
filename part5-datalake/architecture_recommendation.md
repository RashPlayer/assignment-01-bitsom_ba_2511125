## Architecture Recommendation

For a fast-growing food delivery startup dealing with GPS logs, text reviews, payment transactions, and menu images, I highly recommend a Data Lakehouse architecture. 

A Data Warehouse is too rigid to store unstructured files like images, while a traditional Data Lake struggles with the strict reliability needed for financial records. A Lakehouse bridges this gap. Here are three specific reasons why it is the best choice:

1. it seamlessly handles diverse data types. The startup generates structured data (payments), semi-structured high-velocity data (GPS logs), and completely unstructured data (menu images and text reviews). A Lakehouse uses the cheap, flexible storage of a Data Lake to hold all this raw data in its native format without forcing it into a rigid schema first.

2. it guarantees transactional reliability. Payment transactions require strict ACID compliance to ensure no orders or refunds are lost or double-counted. Modern Lakehouse table formats (like Delta Lake or Apache Iceberg) add a transactional layer right on top of the flexible storage, providing the financial safety of a traditional Data Warehouse.

3. it simplifies the analytics pipeline. Instead of paying to store raw files in a Data Lake and then paying again to copy that data into a separate Data Warehouse for reporting, a Lakehouse allows analysts to run business intelligence queries directly on the data. The startup can train AI on menu images and run daily revenue reports from the exact same system.