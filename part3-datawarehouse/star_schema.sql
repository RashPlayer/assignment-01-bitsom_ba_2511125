-- ==========================================================
-- Data Warehouse: Star Schema Design
-- ==========================================================

-- 1. Create Dimension: dim_date
-- Uses an integer date_id (YYYYMMDD) as best practice for date dimensions
CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);

-- 2. Create Dimension: dim_store
CREATE TABLE dim_store (
    store_id VARCHAR(10) PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(50) NOT NULL
);

-- 3. Create Dimension: dim_product
-- Note: 'category' is cleaned (Title case, 'Grocery' mapped to 'Groceries')
CREATE TABLE dim_product (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- 4. Create Fact Table: fact_sales
-- Central table with numeric measures (units_sold, unit_price, total_sales)
CREATE TABLE fact_sales (
    transaction_id VARCHAR(20) PRIMARY KEY,
    date_id INT NOT NULL,
    store_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    customer_id VARCHAR(20) NOT NULL, 
    units_sold INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_sales DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- ==========================================================
-- Insert Cleaned Sample Data
-- ==========================================================

-- Insert into dim_date
INSERT INTO dim_date (date_id, full_date, year, month, day) VALUES (20230829, '2023-08-29', 2023, 8, 29);
INSERT INTO dim_date (date_id, full_date, year, month, day) VALUES (20230815, '2023-08-15', 2023, 8, 15);
INSERT INTO dim_date (date_id, full_date, year, month, day) VALUES (20231020, '2023-10-20', 2023, 10, 20);
INSERT INTO dim_date (date_id, full_date, year, month, day) VALUES (20230512, '2023-05-12', 2023, 5, 12);
INSERT INTO dim_date (date_id, full_date, year, month, day) VALUES (20231027, '2023-10-27', 2023, 10, 27);
INSERT INTO dim_date (date_id, full_date, year, month, day) VALUES (20231122, '2023-11-22', 2023, 11, 22);
INSERT INTO dim_date (date_id, full_date, year, month, day) VALUES (20230321, '2023-03-21', 2023, 3, 21);
INSERT INTO dim_date (date_id, full_date, year, month, day) VALUES (20230102, '2023-01-02', 2023, 1, 2);
INSERT INTO dim_date (date_id, full_date, year, month, day) VALUES (20231029, '2023-10-29', 2023, 10, 29);
INSERT INTO dim_date (date_id, full_date, year, month, day) VALUES (20230604, '2023-06-04', 2023, 6, 4);

-- Insert into dim_store
INSERT INTO dim_store (store_id, store_name, store_city) VALUES ('S001', 'Chennai Anna', 'Chennai');
INSERT INTO dim_store (store_id, store_name, store_city) VALUES ('S003', 'Bangalore MG', 'Bangalore');
INSERT INTO dim_store (store_id, store_name, store_city) VALUES ('S005', 'Mumbai Central', 'Mumbai');
INSERT INTO dim_store (store_id, store_name, store_city) VALUES ('S004', 'Pune FC Road', 'Pune');

-- Insert into dim_product
INSERT INTO dim_product (product_id, product_name, category) VALUES ('P001', 'Speaker', 'Electronics');
INSERT INTO dim_product (product_id, product_name, category) VALUES ('P004', 'Smartwatch', 'Electronics');
INSERT INTO dim_product (product_id, product_name, category) VALUES ('P006', 'Jeans', 'Clothing');
INSERT INTO dim_product (product_id, product_name, category) VALUES ('P008', 'Jacket', 'Clothing');
INSERT INTO dim_product (product_id, product_name, category) VALUES ('P005', 'Atta 10kg', 'Groceries');
INSERT INTO dim_product (product_id, product_name, category) VALUES ('P013', 'Pulses 1kg', 'Groceries');
INSERT INTO dim_product (product_id, product_name, category) VALUES ('P003', 'Phone', 'Electronics');

-- Insert into fact_sales (minimum 10 rows matching dimensions exactly)
INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_sales) 
VALUES ('TXN5000', 20230829, 'S001', 'P001', 'CUST045', 3, 49262.78, 147788.34);

INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_sales) 
VALUES ('TXN5009', 20230815, 'S003', 'P004', 'CUST020', 3, 58851.01, 176553.03);

INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_sales) 
VALUES ('TXN5011', 20231020, 'S005', 'P006', 'CUST045', 13, 2317.47, 30127.11);

INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_sales) 
VALUES ('TXN5017', 20230512, 'S003', 'P008', 'CUST019', 6, 30187.24, 181123.44);

INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_sales) 
VALUES ('TXN5020', 20231027, 'S001', 'P005', 'CUST024', 9, 52464.00, 472176.00);

INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_sales) 
VALUES ('TXN5022', 20231122, 'S003', 'P006', 'CUST020', 3, 2317.47, 6952.41);

INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_sales) 
VALUES ('TXN5025', 20230321, 'S004', 'P013', 'CUST032', 19, 31604.47, 600484.93);

INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_sales) 
VALUES ('TXN5031', 20230102, 'S003', 'P001', 'CUST010', 20, 49262.78, 985255.60);

INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_sales) 
VALUES ('TXN5033', 20231029, 'S005', 'P005', 'CUST017', 8, 52464.00, 419712.00);

INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_sales) 
VALUES ('TXN5036', 20230604, 'S004', 'P003', 'CUST002', 17, 48703.39, 827957.63);