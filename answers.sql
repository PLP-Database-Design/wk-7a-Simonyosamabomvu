--Transforming the ProductDetail Table to 1NF

-- Create a normalized version of the table
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', numbers.n), ',') AS Product
FROM 
    ProductDetail
JOIN 
    (
        SELECT 1 AS n UNION ALL
        SELECT 2 UNION ALL
        SELECT 3 UNION ALL
        SELECT 4  -- Add more numbers if you expect more products per order
    ) numbers
ON 
    CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
ORDER BY 
    OrderID, Product;

--Transforming the OrderDetails Table to 2NF

 --Create Orders table (contains order-level information)

CREATE TABLE Orders AS
SELECT DISTINCT 
    OrderID, 
    CustomerName
FROM 
    OrderDetails;

-- Create OrderItems table (contains product-level information)

CREATE TABLE OrderItems AS
SELECT 
    OrderID,
    Product,
    Quantity
FROM 
    OrderDetails;
