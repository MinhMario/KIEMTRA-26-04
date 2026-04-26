CREATE DATABASE IF NOT EXISTS QuanLyBanHang;
USE QuanLyBanHang;

CREATE TABLE Customer (
    customer_id  INT          PRIMARY KEY AUTO_INCREMENT,
    full_name    VARCHAR(100) NOT NULL,
    address      VARCHAR(150),
    phone        VARCHAR(15)
);

CREATE TABLE Product (
    product_id   INT           PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100)  NOT NULL,
    category     VARCHAR(50),
    price        DECIMAL(10,2),
    status       VARCHAR(20)   DEFAULT 'Còn hàng'
);

CREATE TABLE Orders (
    order_id     INT  PRIMARY KEY AUTO_INCREMENT,
    customer_id  INT,
    order_date   DATE,
    status       VARCHAR(30) DEFAULT 'Đang xử lý',
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE OrderDetail (
    detail_id    INT           PRIMARY KEY AUTO_INCREMENT,
    order_id     INT,
    product_id   INT,
    quantity     INT,
    unit_price   DECIMAL(10,2),
    FOREIGN KEY (order_id)   REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
SELECT product_name, price
FROM Product
WHERE category = 'Nước giải khát'
  AND price BETWEEN 10000 AND 50000
  AND status = 'Còn hàng';
  
SELECT *
FROM Customer
WHERE full_name LIKE 'Nguyễn%'
   OR address = 'Hà Nội';
   
SELECT o.order_id, o.order_date, o.status, c.full_name
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

SELECT c.full_name, o.order_date,
       p.product_name, od.quantity, od.unit_price
FROM OrderDetail od
JOIN Orders  o ON od.order_id   = o.order_id
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Product  p ON od.product_id = p.product_id;

SELECT * FROM Customer 
WHERE customer_id NOT IN(SELECT customer_id FROM Orders);