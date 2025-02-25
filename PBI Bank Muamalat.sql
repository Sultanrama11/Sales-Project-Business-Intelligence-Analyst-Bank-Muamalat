-- membuat table customers

CREATE TABLE customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    CustomerEmail VARCHAR(100) UNIQUE NOT NULL,
    CustomerPhone VARCHAR(20) UNIQUE,
    CustomerAddress TEXT,
    CustomerCity VARCHAR(50),
    CustomerState VARCHAR(50),
    CustomerZip VARCHAR(10)
);

-- Mencoba apakah data sudah berhasil masuk dan melihat berapa rows yang tersedia.
select *
from customers;

SELECT COUNT(*) 
FROM customers;

-- membuat Table products
CREATE TABLE products (
    ProdNumber VARCHAR(50) PRIMARY KEY,   -- Jika ada huruf dan angka
    ProdName VARCHAR(255) NOT NULL,
    Category INT,
    Price varchar(255) NOT NULL -- Menghindari NULL yang error
);

-- Mencoba apakah data sudah berhasil masuk dan melihat berapa rows yang tersedia.
select *
from products;

SELECT COUNT(*) 
FROM products;

-- membuat Table orders
CREATE TABLE orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,  -- ID unik untuk setiap order
    Date varchar (255),                      -- Tanggal order
    CustomerID INT NOT NULL,                 -- ID pelanggan (FK ke customers)
    ProdNumber VARCHAR(50) NOT NULL,         -- Nomor produk (FK ke products)
    Quantity INT NOT NULL                   -- Jumlah produk yang dipesan
);

select *
from orders;

SELECT COUNT(*) 
FROM orders;

-- membuat Table Product Category
CREATE TABLE ProductCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL,
    CategoryAbbreviation VARCHAR(10) NOT NULL
);


-- Mencoba apakah data sudah berhasil masuk dan melihat berapa rows yang tersedia.
select *
from ProductCategory; 	

SELECT COUNT(*) 
FROM ProductCategory;



ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (CustomerID)
REFERENCES customers(CustomerID);

ALTER TABLE orders
ADD CONSTRAINT fk_products_prodnumber
FOREIGN KEY (ProdNumber)
REFERENCES products (ProdNumber);


ALTER TABLE products
ADD CONSTRAINT fk_ProductsCategory
FOREIGN KEY (Category)
REFERENCES ProductCategory(CategoryID);

-- Menghapus setiap Null Values (jaga-jaga jika ada null values)

DELETE FROM customers 
WHERE FirstName IS NULL 
   OR LastName IS NULL 
   OR CustomerEmail IS NULL 
   OR CustomerPhone IS NULL 
   OR CustomerAddress IS NULL 
   OR CustomerCity IS NULL 
   OR CustomerState IS NULL 
   OR CustomerZip IS NULL;

DELETE FROM orders 
WHERE Date IS NULL 
   OR CustomerID IS NULL 
   OR ProdNumber IS NULL 
   OR Quantity IS NULL;

DELETE FROM products 
WHERE ProdName IS NULL 
   OR Category IS NULL 
   OR Price IS NULL;

DELETE FROM productcategory 
WHERE CategoryName IS NULL 
   OR CategoryAbbreviation IS NULL;

-- Membuat Table Master (Soal no. 4)

SELECT 
    o.Date AS order_date,
    pc.CategoryName AS category_name,
    p.ProdName AS product_name,
    p.Price AS product_price,
    o.Quantity AS order_qty,
    (o.Quantity * p.Price) AS total_sales,
    c.CustomerEmail AS cust_email,
    c.CustomerCity AS cust_city
FROM orders o
JOIN customers c ON o.CustomerID = c.CustomerID
JOIN products p ON o.ProdNumber = p.ProdNumber
JOIN productcategory pc ON p.Category = pc.CategoryID
ORDER BY o.Date ASC;

