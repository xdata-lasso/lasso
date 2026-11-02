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
-- DATASET 2
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Benesov', 'Central Bohemia', '88000', '40', '10', '2', 1, 5, 50.0, 8500, 2.0, 2.3, 100, 1500, 1600);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Benesov', 'South Bohemia', '92000', '35', '12', '3', 1, 6, 55.0, 8700, 2.1, 2.4, 105, 1700, 1800);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Beroun', 'Central Bohemia', '75000', '30', '8', '2', 1, 4, 60.0, 8900, 1.8, 2.0, 110, 1400, 1500);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'Kolin', 'Central Bohemia', '95000', '45', '11', '3', 1, 5, 58.0, 8600, 2.5, 2.8, 98, 2000, 2100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'Kutna Hora', 'Central Bohemia', '78000', '38', '9', '2', 1, 5, 52.0, 8400, NULL, 2.6, 92, NULL, 1750);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'F', '1980-03-15', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (102, 'F', '1982-07-20', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (103, 'F', '1975-11-10', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (104, 'F', '1978-04-05', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (105, 'F', '1990-09-25', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (106, 'F', '1965-01-12', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (107, 'F', '1968-06-18', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (108, 'F', '1972-12-01', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (109, 'F', '1985-08-30', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (110, 'M', '1970-02-14', 4);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (111, 'M', '1973-05-22', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A2, COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' GROUP BY T2.district_id, T2.A2 ORDER BY COUNT(T1.client_id) DESC, T2.A2 NULLS LAST LIMIT 10;

/*
Gold Result:
('Beroun', 4)
('Benesov', 3)
('Benesov', 2)
*/

-- Prediction Query
SELECT T1.A2, COUNT(T2.client_id) AS num FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.gender = 'F' GROUP BY T1.A2 ORDER BY num DESC, T1.A2 NULLS LAST LIMIT 10;

/*
Prediction Result:
('Benesov', 5)
('Beroun', 4)
*/