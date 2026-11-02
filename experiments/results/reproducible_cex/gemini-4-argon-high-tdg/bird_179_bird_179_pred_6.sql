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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'Hl.m. Praha', 'Prague', '1200000', '0', '0', '0', 1, 1, 100.0, 12541, 0.2, 0.43, 167, 85677, 99107);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'Brno', 'South Moravia', '400000', '10', '5', '2', 1, 1, 85.5, 9500, 1.5, 2.1, 120, 15000, 18000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (617, 'Ostrava', 'North Moravia', '350000', '5', '5', '1', 1, 1, 90.0, 9100, 3.2, 4.0, 110, 12000, 14000);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (617, 'F', '1998-03-15', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (618, 'M', '1970-01-01', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (616, 'M', '1980-05-05', 20);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 10, 'POPLATEK MESICNE', '1996-05-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 10, 'POPLATEK TYDNE', '1998-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (201, 20, 'POPLATEK MESICNE', '1998-01-10');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (617, 617, 'POPLATEK MESICNE', '1998-04-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 617, 201, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 618, 101, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 616, 102, 'DISPONENT');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 101, '1998-05-01', 99999, 12, 8333.25, 'A');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 101, 'AB', 12345, 88888.0, 'SIPO');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 101, '1998-01-01', 'PRIJEM', 'VKLAD', 500, 1500, 'UROK', 'AB', 999);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (2, 101, '1998-06-15', 'VYDAJ', 'VYBER', 500, 1000, 'SLUZBY', 'CD', 888);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (3, 101, '1997-12-31', 'PRIJEM', 'VKLAD', 9000, 1000, 'UROK', 'AB', 999);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (4, 101, '1999-01-01', 'PRIJEM', 'VKLAD', 8000, 9000, 'UROK', 'AB', 999);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (5, 102, '1998-12-31', 'PRIJEM', 'PREVOD Z UCTU', 300, 2300, 'DUCHOD', 'EF', 777);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (6, 102, '1996-05-05', 'PRIJEM', 'VKLAD', 4000, 2000, 'UROK', 'EF', 777);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (7, 201, '1998-07-20', 'PRIJEM', 'VKLAD', 7777, 7777, 'UROK', 'GH', 101);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (8, 617, '1998-08-08', 'PRIJEM', 'VKLAD', 6170, 6170, 'UROK', 'IJ', 617);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T3.amount) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '1998' AND T1.client_id = 617;

/*
Gold Result:
(1300,)
*/

-- Prediction Query
SELECT SUM(trans.amount) AS total_amount FROM client INNER JOIN disp ON client.client_id = disp.client_id INNER JOIN trans ON disp.account_id = trans.account_id WHERE client.client_id = 617 AND STRFTIME('%Y', trans.date) = '1998';

/*
Prediction Result:
(7777,)
*/