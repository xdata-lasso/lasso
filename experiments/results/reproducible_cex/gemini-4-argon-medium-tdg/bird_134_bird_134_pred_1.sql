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
-- 1. GROUP BY T1.A16 vs GROUP BY T1.district_id (Districts 1 and 2 share the same max A16=100; grouping by A16 yields count 3, grouping by district_id yields max count 2).
-- 2. INNER JOIN vs LEFT JOIN (District 3 has the absolute highest A16=200, but 0 accounts; LEFT JOIN would pick A16=200 with count 0 or 1 if COUNT(*), whereas INNER JOIN picks A16=100 with count 3).
-- 3. ORDER BY T1.A16 DESC vs ORDER BY COUNT(T2.account_id) DESC (District 4 has A16=50 with 4 accounts; ordering by count DESC picks 4, ordering by A16 DESC picks 3).
-- 4. ORDER BY T1.A16 DESC vs ASC (District 5 has A16=10 with 1 account; ASC picks 1, DESC picks 3).
-- 5. COUNT(T2.account_id) vs COUNT(DISTINCT T1.district_id) (For A16=100, account count is 3, distinct district count is 2).
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '1000', '1', '1', '1', 1, 1, 10.0, 1000, 1.0, 1.0, 10, 10, 100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R1', '1000', '1', '1', '1', 1, 1, 10.0, 1000, 1.0, 1.0, 10, 20, 100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'D3', 'R1', '1000', '1', '1', '1', 1, 1, 10.0, 1000, 1.0, 1.0, 10, 30, 200);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'D4', 'R1', '1000', '1', '1', '1', 1, 1, 10.0, 1000, 1.0, 1.0, 10, 500, 50);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'D5', 'R1', '1000', '1', '1', '1', 1, 1, 10.0, 1000, 1.0, 1.0, 10, 5, 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 1, 'MONTHLY', '2020-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 1, 'MONTHLY', '2020-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3, 2, 'MONTHLY', '2020-01-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (4, 4, 'MONTHLY', '2020-01-04');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (5, 4, 'MONTHLY', '2020-01-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (6, 4, 'MONTHLY', '2020-01-06');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (7, 4, 'MONTHLY', '2020-01-07');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (8, 5, 'MONTHLY', '2020-01-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id GROUP BY T1.A16 ORDER BY T1.A16 DESC, COUNT(T2.account_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT("account"."account_id") FROM "account" INNER JOIN "district" ON "account"."district_id" = "district"."district_id" WHERE "district"."A16" = (SELECT MAX("A16") FROM "district");

/*
Prediction Result:
(0,)
*/