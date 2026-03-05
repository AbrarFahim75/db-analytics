-- ============================================================
-- File:    invoice_normalization.sql
-- Course:  IE4 Databases, HAW Hamburg, SoSe 2025
-- Author:  Abrar Fahim
-- Description: Step-by-step normalization of Invoice Data
--              from universal relation to 3NF.
--              Based on SuSe 2020 exam pattern.
-- ============================================================

-- ============================================================
-- ORIGINAL UNIVERSAL RELATION (Unnormalized)
-- ============================================================
-- InvoiceData(invoice_number, date, customer_number, customer_name,
--             customer_address, item_number, article, article_id,
--             amount, price)
--
-- Functional Dependencies:
--   invoice_number              → date, customer_number
--   customer_number             → customer_name, customer_address
--   invoice_number, item_number → article_id, amount
--   article_id                  → article, price
--
-- Primary Key: (invoice_number, item_number)

-- ============================================================
-- STEP 1: First Normal Form (1NF)
-- Split composite attributes into atomic values
-- ============================================================

CREATE TABLE invoice_data_1nf (
    invoice_number  INT         NOT NULL,
    date            DATE,
    customer_number INT,
    customer_name   VARCHAR(100),
    customer_address VARCHAR(200),
    item_number     INT         NOT NULL,
    article         VARCHAR(100),
    article_id      VARCHAR(20),
    amount          INT,
    price           DECIMAL(10,2),
    PRIMARY KEY (invoice_number, item_number)
);

-- ============================================================
-- STEP 2: Second Normal Form (2NF)
-- Remove partial dependencies
-- customer_number depends only on invoice_number (partial dep)
-- article_id depends on (invoice_number, item_number) (full dep)
-- ============================================================

CREATE TABLE invoice_2nf (
    invoice_number  INT     PRIMARY KEY,
    date            DATE,
    customer_number INT
);

CREATE TABLE invoice_item_2nf (
    invoice_number  INT         NOT NULL,
    item_number     INT         NOT NULL,
    article_id      VARCHAR(20),
    amount          INT,
    PRIMARY KEY (invoice_number, item_number),
    FOREIGN KEY (invoice_number) REFERENCES invoice_2nf(invoice_number)
);

CREATE TABLE customer_2nf (
    customer_number INT         PRIMARY KEY,
    customer_name   VARCHAR(100),
    customer_address VARCHAR(200)
);

CREATE TABLE article_2nf (
    article_id      VARCHAR(20) PRIMARY KEY,
    article         VARCHAR(100),
    price           DECIMAL(10,2)
);

-- ============================================================
-- STEP 3: Third Normal Form (3NF)
-- Remove transitive dependencies
-- In this case, 2NF already achieves 3NF because:
--   - invoice_2nf: no transitive deps (customer_number is FK)
--   - customer_2nf: customer_name, customer_address depend directly on PK
--   - article_2nf: article, price depend directly on PK
--   - invoice_item_2nf: article_id, amount depend on full composite PK
-- ============================================================

-- Final 3NF schema:
-- INVOICE(invoice_number PK, date, customer_number FK)
-- CUSTOMER(customer_number PK, customer_name, customer_address)
-- ARTICLE(article_id PK, article, price)
-- INVOICE_ITEM(invoice_number FK, item_number, article_id FK, amount)
--     PK: (invoice_number, item_number)


---
