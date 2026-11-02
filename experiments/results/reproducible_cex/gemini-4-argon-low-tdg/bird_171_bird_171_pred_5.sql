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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Dist1', 'East Bohemia', '100', '10', '10', '10', 1, 1, 50.5, 8000, 1.2, 1.5, 100, 100, 1000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Dist2', 'East Bohemia', '200', '20', '20', '20', 2, 2, 60.5, 8500, 1.3, 1.6, 110, 200, 1000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Dist3', 'East Bohemia', '300', '30', '30', '30', 3, 3, 70.5, 9000, 1.4, 1.7, 120, 300, 2500);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'Dist4', 'North Bohemia', '400', '40', '40', '40', 4, 4, 80.5, 9500, 1.5, 1.8, 130, 400, 400);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'Dist5', 'North Bohemia', '500', '50', '50', '50', 5, 5, 90.5, 9800, 1.6, 1.9, 140, 500, 900);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (6, 'Dist6', 'South Bohemia', '600', '60', '60', '60', 6, 6, 40.5, 7000, 1.1, 1.4, 90, 600, 8000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (7, 'East Bohemia', 'Central Bohemia', '700', '70', '70', '70', 7, 7, 30.5, 7500, 1.0, 1.2, 80, 700, 9000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (8, 'North Bohemia', 'West Bohemia', '800', '80', '80', '80', 8, 8, 20.5, 7200, 0.9, 1.1, 70, 800, 9500);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 1, 'POPLATEK MESICNE', '1995-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 4, 'POPLATEK MESICNE', '1995-01-03');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (201, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (202, 'F', '1975-01-01', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (301, 201, 101, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (302, 202, 102, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(A3 = 'East Bohemia', A16, 0)) - SUM(IIF(A3 = 'North Bohemia', A16, 0)) FROM district;

/*
Gold Result:
(3200,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN T1.A3 = 'north Bohemia' THEN T1.A16 ELSE 0 END) - SUM(CASE WHEN T1.A3 = 'east Bohemia' THEN T1.A16 ELSE 0 END) FROM district AS T1;

/*
Prediction Result:
(0,)
*/