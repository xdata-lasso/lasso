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
-- General comprehensive dataset:
-- 1. Tests `gender = 'F'` by having an older 'M' client in a different district.
-- 2. Tests `ORDER BY birth_date ASC` by having multiple 'F' clients in different districts with different birth dates.
-- 3. Tests global `MAX(A11) - MIN(A11)` across all districts (including districts with no accounts or no clients).
-- 4. Tests `ORDER BY T1.account_id` in outer query by having multiple accounts in the target district.
-- 5. Tests `account` vs `disp` confusion by linking the oldest female client to an account in a DIFFERENT district via `disp`.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '1000', '1', '1', '1', 1, 1, 10.0, 8000, 1.0, 1.0, 10, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '2000', '2', '2', '2', 2, 2, 20.0, 10000, 2.0, 2.0, 20, 20, 20);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'D3', 'R3', '3000', '3', '3', '3', 3, 3, 30.0, 15000, 3.0, 3.0, 30, 30, 30);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'D4', 'R4', '4000', '4', '4', '4', 4, 4, 40.0, 5000, 4.0, 4.0, 40, 40, 40);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'M', '1940-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'F', '1950-05-15', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'F', '1980-10-20', 3);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (25, 2, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 2, 'POPLATEK TYDNE', '1996-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 3, 'POPLATEK MESICNE', '1994-01-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (100, 1, 10, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (200, 2, 10, 'USER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (300, 3, 20, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (400, 3, 25, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, (SELECT MAX(A11) - MIN(A11) FROM district) FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.district_id = (SELECT district_id FROM client WHERE gender = 'F' ORDER BY birth_date ASC, client.client_id NULLS LAST LIMIT 1) ORDER BY T2.A11 DESC, T1.account_id NULLS LAST, T2.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(20, 10000)
*/

-- Prediction Query
SELECT account.account_id, (SELECT MAX(a11) - MIN(a11) FROM district) AS salary_gap FROM account INNER JOIN disp ON account.account_id = disp.account_id INNER JOIN client ON disp.client_id = client.client_id INNER JOIN district ON client.district_id = district.district_id WHERE client.gender = 'F' AND client.birth_date = (SELECT MIN(birth_date) FROM client WHERE gender = 'F' AND district_id = (SELECT district_id FROM district WHERE a11 = (SELECT MIN(a11) FROM district)));

/*
Prediction Result:
*/