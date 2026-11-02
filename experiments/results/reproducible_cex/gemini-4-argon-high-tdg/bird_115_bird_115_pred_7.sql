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
-- DATASET 4
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Empty District', 'south Bohemia', '999', '10', '10', '5', 1, 5, 80.0, 10000, 1.5, 2.0, 120, 1000, 1100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Female Only District', 'south Bohemia', '888', '9', '9', '4', 1, 4, 75.0, 9500, 1.8, 2.2, 110, 900, 950);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Mixed District', 'south Bohemia', '777', '8', '8', '3', 1, 3, 70.0, 9000, 2.0, 2.5, 100, 800, 850);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'F', '1980-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'F', '1982-02-02', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'F', '1984-03-03', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (4, 'M', '1985-04-04', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (5, 'M', '1986-05-05', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (6, 'F', '1987-06-06', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'south Bohemia' GROUP BY T2.A4 ORDER BY T2.A4 DESC, CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN client.gender = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(client.client_id) AS male_percentage FROM client INNER JOIN district ON client.district_id = district.district_id WHERE district.a3 = 'south Bohemia' AND district.a4 = (SELECT MAX(a4) FROM district WHERE a3 = 'south Bohemia');

/*
Prediction Result:
(None,)
*/