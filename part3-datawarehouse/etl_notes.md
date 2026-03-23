## ETL Decisions

### Decision 1 - Standardizing Date Formats and Generating Surrogate Keys
Problem: The raw date column contained highly inconsistent string formats, mixing DD/MM/YYYY , DD-MM-YYYY , and YYYY-MM-DD . If loaded directly, time-series analysis would be impossible because the database wouldn't recognize the strings as chronologically ordered dates.
Resolution: During extraction, the dates were parsed into standard Python datetime objects to ensure uniformity. For the load phase into the data warehouse, the dates were formatted into a strict YYYY-MM-DD string for the full_date attribute, and transformed into an integer format ( YYYYMMDD ) to serve as an optimized, non-null surrogate primary key ( date_id ) for the dim_date table. 

### Decision 2 - Imputing Missing Store Location Data
Problem: The store_city column had 19 explicit NULL values in the raw dataset. Leaving these as NULL would break the NOT NULL constraint of our dimension tables and cause issues for regional sales reporting. 
Resolution: I analyzed the surrounding data and noticed that the store_city could be deterministically derived from the store_name (e.g., "Chennai Anna" is always in Chennai). I built a dictionary mapping the known store names to their respective cities from the complete records, and used this to impute the 19 missing store_city values before creating the dim_store records. 

### Decision 3 - Unifying Product Category Casing and Naming
Problem: The category column suffered from free-text data entry issues. It contained a mix of lowercase and title case ("electronics" vs "Electronics"), as well as singular and plural forms ("Grocery" vs "Groceries"). This fragmentation would cause aggregate queries to split revenue across identical categories.
Resolution: I applied a string transformation rule to strip whitespace and convert all category strings to Title Case. Then, I applied a specific replacement rule mapping "Grocery" directly to "Groceries" to ensure all related products rolled up cleanly under a single, unified dimension value.