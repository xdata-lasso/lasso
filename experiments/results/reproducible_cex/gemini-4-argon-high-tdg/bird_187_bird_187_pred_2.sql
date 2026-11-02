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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (50, 'Praha', 'Bohemia', '100000', '10', '5', '2', 1, 1, 100.0, 10000, 1.2, 1.5, 120, 1000, 1200);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (301, 'M', '1970-01-15', 50);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (302, 'F', '1975-05-20', 50);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (303, 'M', '1980-08-10', 50);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (304, 'F', '1985-11-30', 50);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 50, 'POPLATEK TYDNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 50, 'POPLATEK TYDNE', '1993-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 50, 'POPLATEK TYDNE', '1993-03-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (104, 50, 'POPLATEK MESICNE', '1993-04-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (105, 50, 'POPLATEK PO OBRATU', '1993-05-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (106, 50, 'POPLATEK TYDNE', '1993-06-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (201, 301, 101, 'USER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (202, 302, 101, 'USER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (203, 303, 101, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (204, 303, 102, 'USER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (205, 304, 103, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (206, 301, 104, 'USER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (207, 302, 105, 'DISPONENT');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM account AS T1 INNER JOIN disp AS T2 ON T2.account_id = T1.account_id WHERE T1.frequency = 'POPLATEK TYDNE' AND T2.type = 'USER';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "client"."client_id") FROM "account" INNER JOIN "disp" ON "account"."account_id" = "disp"."account_id" INNER JOIN "client" ON "disp"."client_id" = "client"."client_id" WHERE "account"."frequency" = 'POPLATEK TYDNE' AND "disp"."type" = 'OWNER';

/*
Prediction Result:
(2,)
*/