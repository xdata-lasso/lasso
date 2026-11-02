-- Schema DDL
CREATE TABLE account (account_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, district_id INTEGER DEFAULT 0 NOT NULL, frequency TEXT NOT NULL, date DATE NOT NULL, FOREIGN KEY (district_id) REFERENCES district (district_id));

CREATE TABLE card (card_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, disp_id INTEGER NOT NULL, type TEXT NOT NULL, issued DATE NOT NULL, FOREIGN KEY (disp_id) REFERENCES disp (disp_id));

CREATE TABLE client (client_id INTEGER NOT NULL PRIMARY KEY, gender TEXT NOT NULL, birth_date DATE NOT NULL, district_id INTEGER NOT NULL, FOREIGN KEY (district_id) REFERENCES district (district_id));

CREATE TABLE disp (disp_id INTEGER NOT NULL PRIMARY KEY, client_id INTEGER NOT NULL, account_id INTEGER NOT NULL, type TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id), FOREIGN KEY (client_id) REFERENCES client (client_id));

CREATE TABLE district (district_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, A2 TEXT NOT NULL, A3 TEXT NOT NULL, A4 TEXT NOT NULL, A5 TEXT NOT NULL, A6 TEXT NOT NULL, A7 TEXT NOT NULL, A8 INTEGER NOT NULL, A9 INTEGER NOT NULL, A10 REAL NOT NULL, A11 INTEGER NOT NULL, A12 REAL NULL, A13 REAL NOT NULL, A14 INTEGER NOT NULL, A15 INTEGER NULL, A16 INTEGER NOT NULL);

CREATE TABLE loan (loan_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER NOT NULL, date DATE NOT NULL, amount INTEGER NOT NULL, duration INTEGER NOT NULL, payments REAL NOT NULL, status TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

CREATE TABLE "order" (order_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER NOT NULL, bank_to TEXT NOT NULL, account_to INTEGER NOT NULL, amount REAL NOT NULL, k_symbol TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

CREATE TABLE trans (trans_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER DEFAULT 0 NOT NULL, date DATE NOT NULL, type TEXT NOT NULL, operation TEXT NULL, amount INTEGER NOT NULL, balance INTEGER NOT NULL, k_symbol TEXT NULL, bank TEXT NULL, account INTEGER NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT necessity (District 1 has two female clients).
-- 2. Gender filter (District 2 has only male client, District 3 has female client).
-- 3. Boundary values for A11: 6000 (inclusive lower bound), 5999 (exclusive lower bound), 10000 (inclusive upper bound), 10001 (exclusive upper bound).
-- 4. Join necessity (District 7 meets A11 criteria but has no clients).
-- 5. Confounding columns (A8, A9, A14, A16 have values outside [6000, 10000] when A11 is inside, and inside when A11 is outside).
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '1000', '10', '10', '10', 100, 100, 50.0, 8000, 1.0, 1.0, 100, 100, 100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '1000', '10', '10', '10', 8000, 8000, 50.0, 8000, 1.0, 1.0, 8000, 8000, 8000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'D3', 'R3', '1000', '10', '10', '10', 100, 100, 50.0, 6000, 1.0, 1.0, 100, 100, 100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'D4', 'R4', '1000', '10', '10', '10', 100, 100, 50.0, 10000, 1.0, 1.0, 100, 100, 100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'D5', 'R5', '1000', '10', '10', '10', 8000, 8000, 50.0, 5999, 1.0, 1.0, 8000, 8000, 8000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (6, 'D6', 'R6', '1000', '10', '10', '10', 8000, 8000, 50.0, 10001, 1.0, 1.0, 8000, 8000, 8000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (7, 'D7', 'R7', '1000', '10', '10', '10', 100, 100, 50.0, 7500, 1.0, 1.0, 100, 100, 100);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'F', '1980-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (102, 'F', '1985-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (103, 'M', '1980-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (104, 'F', '1980-01-01', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (105, 'F', '1980-01-01', 4);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (106, 'F', '1980-01-01', 5);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (107, 'F', '1980-01-01', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.district_id FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' AND T2.A11 BETWEEN 6000 AND 10000;

/*
Gold Result:
(1,)
(3,)
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "district"."district_id") FROM "client" JOIN "district" ON "client"."district_id" = "district"."district_id" WHERE "client"."gender" = 'F' AND "district"."a11" > 6000 AND "district"."a11" < 10000;

/*
Prediction Result:
(1,)
*/