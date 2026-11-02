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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Praha', 'Prague', '1204953', '0', '0', '0', 1, 1, 100.0, 12541, 15.0, 10.15, 167, 85677, 99107);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Karvina', 'north Moravia', '285387', '0', '2', '8', 5, 5, 89.9, 10177, 8.5, 9.85, 81, 9878, 10108);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Most', 'north Bohemia', '119283', '15', '8', '2', 1, 6, 85.6, 9832, 7.2, 10.45, 95, 4210, 4505);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'Benešov', 'central Bohemia', '88884', '80', '26', '6', 12, 15, 46.7, 8507, 1.1, 1.25, 250, 99999, 2591);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'M', '1970-01-15', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (201, 'F', '1965-05-20', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (202, 'M', '1980-11-30', 2);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '1995-03-10');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 2, 'POPLATEK MESICNE', '1995-04-12');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (21, 2, 'POPLATEK TYDNE', '1996-01-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1001, 101, 10, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2001, 201, 20, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2002, 202, 21, 'OWNER');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (501, 1001, 'gold', '1997-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (601, 10, '1996-06-01', 48000, 24, 2000.0, 'A');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (701, 10, 'AB', 123456, 1500.0, 'SIPO');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (801, 10, '1995-03-10', 'PRIJEM', 'VKLAD', 5000, 5000, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT district_id, A2 FROM district ORDER BY A13 DESC, district.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(3, 'Most')
*/

-- Prediction Query
SELECT A2, A3 FROM district ORDER BY A13 DESC, district.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Most', 'north Bohemia')
*/