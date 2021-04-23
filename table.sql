DROP DATABASE IF EXISTS car_sales;
CREATE DATABASE car_sales;
USE car_sales;

CREATE TABLE customers
(
    customerNumber   INT PRIMARY KEY,
    customerName     VARCHAR(50) NOT NULL,
    contactLastName  VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    phone            VARCHAR(50) NOT NULL,
    addressLine1     VARCHAR(50) NOT NULL,
    addressLine2     VARCHAR(50),
    city             VARCHAR(50) NOT NULL,
    state            VARCHAR(50) NOT NULL,
    postalCode       VARCHAR(15) NOT NULL,
    country          VARCHAR(15) NOT NULL,
    creditLimit      INT
);

CREATE TABLE orders
(
    orderNumber     INT         NOT NULL UNIQUE,
    orderDate       DATE        NOT NULL,
    requiredDate    DATE        NOT NULL,
    shippedDate     DATE        NOT NULL,
    status          VARCHAR(15) NOT NULL,
    comments        LONGTEXT,
    quantityOrdered INT         NOT NULL,
    priceEach       DOUBLE      NOT NULL
);

CREATE TABLE payments
(
    customerNumber INT PRIMARY KEY,
    checkNumber    VARCHAR(50) NOT NULL,
    paymentDate    DATE        NOT NULL,
    amount         DOUBLE      NOT NULL
);

CREATE TABLE products
(
    productCode        VARCHAR(15) PRIMARY KEY,
    productName        VARCHAR(70) NOT NULL,
    productScale       VARCHAR(10) NOT NULL,
    productVendor      VARCHAR(50) NOT NULL,
    productDescription LONGTEXT    NOT NULL,
    quantityInStock    INT         NOT NULL,
    buyPrice           DOUBLE      NOT NULL,
    MSRP               DOUBLE      NOT NULL
);

CREATE TABLE productLines
(
    productLine     VARCHAR(50) PRIMARY KEY,
    textDescription LONGTEXT,
    image           VARCHAR(2048)
);

CREATE TABLE employees
(
    employeeNumber INT          NOT NULL UNIQUE,
    lastName       VARCHAR(50)  NOT NULL,
    firstName      VARCHAR(50)  NOT NULL,
    email          VARCHAR(100) NOT NULL,
    jobTitle       VARCHAR(50)  NOT NULL
);

CREATE TABLE offices
(
    officeCode   VARCHAR(10) PRIMARY KEY,
    city         VARCHAR(50) NOT NULL,
    phone        VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50),
    state        VARCHAR(50),
    country      VARCHAR(50) NOT NULL,
    postalCode   VARCHAR(15) NOT NULL
);

ALTER TABLE orders
    ADD customerNumber INT,
    ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber);

ALTER TABLE payments
    ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber);

CREATE TABLE orderDetails
(
    orderNumber INT,
    productCode VARCHAR(15),
    FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber),
    FOREIGN KEY (productCode) REFERENCES products (productCode)
);

ALTER TABLE products
    ADD productLine VARCHAR(50),
    ADD FOREIGN KEY (productLine) REFERENCES productLines (productLine);

ALTER TABLE payments
    ADD salesRepEmployeeNumber INT,
    ADD FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber);

ALTER TABLE employees
    ADD reportTo INT,
    ADD CONSTRAINT FK_reportTo FOREIGN KEY (reportTo) REFERENCES customers (customerNumber);

ALTER TABLE customers
    ADD officeCode VARCHAR(10),
    ADD FOREIGN KEY (officeCode) REFERENCES offices (officeCode);
