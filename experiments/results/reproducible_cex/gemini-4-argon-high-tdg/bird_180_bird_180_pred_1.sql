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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Hradec Kralove', 'east Bohemia', '100000', '50', '20', '10', 1, 5, 75.5, 9000, 1.5, 2.0, 120, 2000, 2500);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Liberec', 'north Bohemia', '150000', '40', '15', '8', 1, 4, 80.0, 8500, 2.1, 2.5, 110, 3000, 3200);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (10, 'M', '1985-04-12', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (20, 'F', '1985-08-22', 2);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 1, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (200, 1, 'POPLATEK MESICNE', '1994-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (300, 2, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 10, 300, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 20, 100, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 10, 100, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id, T3.account_id FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN account AS T3 ON T2.district_id = T3.district_id WHERE T2.A3 = 'east Bohemia' AND STRFTIME('%Y', T1.birth_date) BETWEEN '1983' AND '1987';

/*
Gold Result:
(10, 100)
(10, 200)
*/

-- Prediction Query
SELECT "client"."client_id", "client"."birth_date" FROM "client" JOIN "disp" ON "client"."client_id" = "disp"."client_id" JOIN "account" ON "disp"."account_id" = "account"."account_id" JOIN "district" ON "account"."district_id" = "district"."district_id" WHERE "client"."birth_date" BETWEEN '1983-01-01' AND '1987-12-31' AND "district"."a3" = 'east Bohemia';

/*
Prediction Result:
(20, '1985-08-22')
(10, '1985-04-12')
*/