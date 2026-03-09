-- ============================================================
-- File:    normalization_examples.sql
-- Course:  IE4 Databases, HAW Hamburg, SoSe 2025
-- Author:  Abrar Fahim
-- Description: Two complete normalization examples:
--   1. Invoice Data (from SuSe 2020 exam pattern)
--   2. Furniture Order Database (from Lab 3, Assignments 3-4)
-- ============================================================


-- ############################################################
-- EXAMPLE 1: INVOICE DATA NORMALIZATION
-- Source: SuSe 2020 exam pattern
-- ############################################################

-- ORIGINAL UNIVERSAL RELATION:
-- InvoiceData(invoice_number, date, customer_number, customer_name,
--             customer_address, item_number, article, article_id,
--             amount, price)
--
-- FUNCTIONAL DEPENDENCIES:
--   invoice_number                → date, customer_number
--   customer_number               → customer_name, customer_address
--   invoice_number, item_number   → article_id, amount
--   article_id                    → article, price
--
-- PRIMARY KEY: (invoice_number, item_number)


-- STEP 1 → 1NF: Already in 1NF (all values atomic)

-- STEP 2 → 2NF: Remove partial dependencies
--   Partial dep: invoice_number → date, customer_number
--   (depends on only PART of the composite PK)

CREATE TABLE Invoice (
    invoice_number  INT PRIMARY KEY,
    date            DATE,
    customer_number INT NOT NULL
);

CREATE TABLE Customer (
    customer_number  INT PRIMARY KEY,
    customer_name    VARCHAR(100),
    customer_address VARCHAR(200)
);

CREATE TABLE Article (
    article_id  VARCHAR(20) PRIMARY KEY,
    article     VARCHAR(100),
    price       DECIMAL(10,2)
);

CREATE TABLE InvoiceItem (
    invoice_number INT NOT NULL,
    item_number    INT NOT NULL,
    article_id     VARCHAR(20),
    amount         INT,
    PRIMARY KEY (invoice_number, item_number),
    FOREIGN KEY (invoice_number) REFERENCES Invoice(invoice_number),
    FOREIGN KEY (article_id)     REFERENCES Article(article_id)
);

-- Add FK from Invoice to Customer
ALTER TABLE Invoice
ADD CONSTRAINT fk_invoice_customer
FOREIGN KEY (customer_number) REFERENCES Customer(customer_number);

-- STEP 3 → 3NF: Check for transitive dependencies
--   Invoice: invoice_number → customer_number (FK, not transitive)
--   Customer: customer_number → name, address (direct, OK)
--   Article: article_id → article, price (direct, OK)
--   InvoiceItem: (inv_no, item_no) → article_id, amount (full dep, OK)
-- RESULT: Already in 3NF after 2NF decomposition.


-- ############################################################
-- EXAMPLE 2: FURNITURE ORDER — VERSION 1 (one product per order)
-- Source: Lab 3, Assignment 3
-- ############################################################

-- ORIGINAL RELATION:
-- ORDER(CustomerID, Name, Address, OrderID, Product, Quantity, Price)
--
-- Sample data:
--   24, Maria Müller, Wegstraße 12b Berlin, 101, Table, 2, 150.0
--   24, Maria Müller, Wegstraße 12b Berlin, 102, Chair, 5, 80.0
--   18, Klaus Schmidt, Hauptstraße 4 Hamburg, 103, Table, 1, 130.0
--   16, Petra Wagner, Lindenallee 7 Munich,  104, Sofa,  2, 200.0
--
-- FUNCTIONAL DEPENDENCIES:
--   CustomerID → Name, Address
--   OrderID    → CustomerID, Product, Quantity, Price
--   Product    → Price
--
-- CANDIDATE KEYS: {OrderID} (since each order has one product)
-- PRIMARY KEY: OrderID
--
-- ANALYSIS:
--   1NF? YES — all values are atomic
--   2NF? YES — PK is single attribute, so no partial deps possible
--   3NF? NO  — transitive dependencies exist:
--     OrderID → CustomerID → Name, Address  (transitive)
--     OrderID → Product → Price             (transitive)

-- DECOMPOSITION TO 3NF:

CREATE TABLE Furniture_Customer (
    CustomerID  INT PRIMARY KEY,
    Name        VARCHAR(100),
    Address     VARCHAR(200)
);

CREATE TABLE Furniture_Product (
    Product     VARCHAR(100) PRIMARY KEY,
    Price       DECIMAL(10,2)
);

CREATE TABLE Furniture_Order_v1 (
    OrderID     INT PRIMARY KEY,
    CustomerID  INT NOT NULL,
    Product     VARCHAR(100) NOT NULL,
    Quantity    INT,
    FOREIGN KEY (CustomerID) REFERENCES Furniture_Customer(CustomerID),
    FOREIGN KEY (Product)    REFERENCES Furniture_Product(Product)
);


-- ############################################################
-- EXAMPLE 3: FURNITURE ORDER — VERSION 2 (multiple products per order)
-- Source: Lab 3, Assignment 4
-- ############################################################

-- ORIGINAL RELATION (same columns, but now one order can have many products):
--   CustomerID, Name, Address, OrderID, Product, Quantity, Price
--
-- FUNCTIONAL DEPENDENCIES:
--   CustomerID          → Name, Address
--   OrderID             → CustomerID
--   OrderID, Product    → Quantity
--   Product             → Price
--
-- PRIMARY KEY: (OrderID, Product) — because each order can have multiple products
--
-- ANALYSIS:
--   1NF? YES
--   2NF? NO — partial dependencies:
--     OrderID → CustomerID (depends on part of composite PK)
--     Product → Price      (depends on part of composite PK)
--   3NF? NO — transitive: CustomerID → Name, Address

-- STEP 1: Decompose to 2NF (remove partial dependencies)

CREATE TABLE Furniture_Customer_v2 (
    CustomerID  INT PRIMARY KEY,
    Name        VARCHAR(100),
    Address     VARCHAR(200)
);

CREATE TABLE Furniture_Order_v2 (
    OrderID     INT PRIMARY KEY,
    CustomerID  INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Furniture_Customer_v2(CustomerID)
);

CREATE TABLE Furniture_Product_v2 (
    Product     VARCHAR(100) PRIMARY KEY,
    Price       DECIMAL(10,2)
);

CREATE TABLE Furniture_OrderItem_v2 (
    OrderID     INT NOT NULL,
    Product     VARCHAR(100) NOT NULL,
    Quantity    INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Furniture_Order_v2(OrderID),
    FOREIGN KEY (Product) REFERENCES Furniture_Product_v2(Product)
);

-- 3NF check: No transitive dependencies remain. DONE.


-- ############################################################
-- EXAMPLE 4: COMPANY RELATION (from SoSe 2024 exam)
-- ############################################################

-- ORIGINAL RELATION:
-- COMPANY(employeeID, employeeName, departmentName, projectID, projectName, hours)
--
-- FUNCTIONAL DEPENDENCIES:
--   employeeID, projectID   → hours
--   employeeID              → employeeName, departmentName
--   projectID               → projectName
--   projectName             → projectID
--
-- CANDIDATE KEYS:
--   {employeeID, projectID}   (since employeeID,projectID → hours)
--   {employeeID, projectName} (since projectName → projectID)
--
-- ANALYSIS:
--   1NF? YES
--   2NF? NO — partial dependencies:
--     employeeID → employeeName, departmentName
--     projectID  → projectName
--   3NF? NO (fails 2NF already)

-- DECOMPOSITION TO 3NF:

CREATE TABLE Company_Employee (
    employeeID      INT PRIMARY KEY,
    employeeName    VARCHAR(100),
    departmentName  VARCHAR(100)
);

CREATE TABLE Company_Project (
    projectID       INT PRIMARY KEY,
    projectName     VARCHAR(100) UNIQUE  -- projectName is also a candidate key
);

CREATE TABLE Company_WorksOn (
    employeeID  INT NOT NULL,
    projectID   INT NOT NULL,
    hours       DECIMAL(5,1),
    PRIMARY KEY (employeeID, projectID),
    FOREIGN KEY (employeeID) REFERENCES Company_Employee(employeeID),
    FOREIGN KEY (projectID)  REFERENCES Company_Project(projectID)
);
