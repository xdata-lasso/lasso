-- Schema DDL
CREATE TABLE "MANUFACTURERS" (
    "CODE" INT,
    "NAME" TEXT,
    "HEADQUARTER" TEXT,
    "FOUNDER" TEXT,
    "REVENUE" FLOAT,
    PRIMARY KEY ("CODE")
);
CREATE TABLE "PRODUCTS" (
    "CODE" INT,
    "MANUFACTURER" INT,
    "NAME" TEXT,
    "PRICE" FLOAT,
    PRIMARY KEY ("CODE"),
    FOREIGN KEY ("MANUFACTURER") REFERENCES "MANUFACTURERS"("CODE")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MANUFACTURERS VALUES (-2147483648, 0, 19, 20, 21);
INSERT INTO MANUFACTURERS VALUES (-2147483647, 0, 23, 24, 25);
INSERT INTO PRODUCTS VALUES (-2147483648, -2147483647, 18, -1);
INSERT INTO PRODUCTS VALUES (-2147483647, -2147483648, 22, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_t1_price_, name FROM (SELECT code, name, AVG(price) AS meanprice FROM (SELECT code, name, headquarter, founder, revenue, code_other, name_other, price, code AS manufacturer FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.headquarter AS headquarter, LHS.founder AS founder, LHS.revenue AS revenue, RHS.code AS code_other, RHS.name AS name_other, RHS.price AS price FROM manufacturers AS LHS INNER JOIN products AS RHS ON (LHS.code = RHS.manufacturer))) GROUP BY code, name) ORDER BY avg_t1_price_, name NULLS LAST;

/*
Gold Result:
(-1.0, '0')
(1.0, '0')
*/

-- Prediction Query
SELECT AVG(T1.price), T2.name FROM products AS T1 JOIN manufacturers AS T2 ON T1.Manufacturer = T2.code GROUP BY T2.name;

/*
Prediction Result:
(0.0, '0')
*/