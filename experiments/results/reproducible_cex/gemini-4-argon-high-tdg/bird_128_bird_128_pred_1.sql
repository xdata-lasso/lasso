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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Zlin', 'Moravia', '100000', '10', '5', '2', 1, 5, 75.5, 9000, 2.1, 2.5, 110, 1500, 1600);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Brno', 'Moravia', '300000', '20', '10', '4', 2, 8, 85.0, 10500, 3.0, 3.2, 140, 4000, 4200);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Praha', 'Bohemia', '1200000', '50', '20', '10', 1, 1, 100.0, 12500, 0.5, 0.8, 170, 85000, 90000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'Ostrava', 'Silesia', '320000', '15', '8', '3', 1, 4, 90.0, 10000, 4.5, 5.1, 100, 12000, 13000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'Plzen', 'Bohemia', '170000', '12', '6', '2', 1, 3, 88.0, 9800, 1.8, 2.0, 130, 5000, 5200);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (6, 'Liberec', 'Bohemia', '150000', '18', '7', '3', 1, 6, 80.0, 9200, 2.2, 2.6, 125, 3500, 3700);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (7, 'Olomouc', 'Moravia', '220000', '30', '12', '5', 1, 7, 70.0, 8900, 3.1, 3.5, 115, 4100, 4300);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (8, 'Kladno', 'Bohemia', '160000', '25', '9', '4', 1, 5, 72.0, 9500, 2.9, 3.1, 118, 3800, 3900);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (9, 'Most', 'Bohemia', '120000', '14', '5', '2', 1, 4, 82.0, 9700, 5.0, 5.8, 95, 4500, 4800);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'Znojmo', 'Moravia', '110000', '40', '15', '3', 1, 6, 55.0, 8400, 4.0, 4.4, 105, 2100, 2300);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (11, 'Cheb', 'Bohemia', '90000', '22', '8', '2', 1, 5, 68.0, 8800, 2.5, 2.9, 120, 2500, 2700);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (12, 'Tabor', 'Bohemia', '105000', '35', '11', '3', 1, 6, 62.0, 8600, 1.9, 2.1, 112, 1900, 2000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (13, 'Pisek', 'Bohemia', '70000', '28', '9', '1', 1, 4, 60.0, 8500, 1.5, 1.8, 108, 1200, 1300);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'F', '1970-01-01', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'F', '1971-01-01', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'F', '1972-01-01', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (4, 'F', '1973-01-01', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (5, 'F', '1974-01-01', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (6, 'F', '1975-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (7, 'F', '1976-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (8, 'F', '1977-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (9, 'F', '1978-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (10, 'F', '1979-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (11, 'F', '1980-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (12, 'F', '1981-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (13, 'F', '1982-01-01', 4);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (14, 'F', '1983-01-01', 4);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (15, 'F', '1984-01-01', 4);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (16, 'M', '1984-05-01', 4);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (17, 'M', '1984-06-01', 4);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (18, 'M', '1984-07-01', 4);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (19, 'F', '1985-01-01', 5);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (20, 'F', '1986-01-01', 5);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (21, 'F', '1987-01-01', 6);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (22, 'F', '1988-01-01', 6);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (23, 'F', '1989-01-01', 7);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (24, 'F', '1990-01-01', 7);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (25, 'F', '1991-01-01', 8);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (26, 'F', '1992-01-01', 8);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (27, 'F', '1993-01-01', 9);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (28, 'F', '1994-01-01', 9);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (29, 'F', '1995-01-01', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (30, 'F', '1996-01-01', 11);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (31, 'M', '1960-01-01', 12);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (32, 'M', '1961-01-01', 12);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (33, 'M', '1962-01-01', 12);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (34, 'M', '1963-01-01', 12);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (35, 'M', '1964-01-01', 12);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (36, 'M', '1965-01-01', 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A2, COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' GROUP BY T2.district_id, T2.A2 ORDER BY COUNT(T1.client_id) DESC, T2.A2 NULLS LAST LIMIT 10;

/*
Gold Result:
('Praha', 5)
('Brno', 4)
('Ostrava', 3)
('Zlin', 3)
('Kladno', 2)
('Liberec', 2)
('Most', 2)
('Olomouc', 2)
('Plzen', 2)
('Cheb', 1)
*/

-- Prediction Query
SELECT T2.A2 AS district_name, COUNT(T1.client_id) AS female_client_count FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' GROUP BY T2.A2 ORDER BY female_client_count DESC, district_name NULLS LAST LIMIT 9;

/*
Prediction Result:
('Praha', 5)
('Brno', 4)
('Ostrava', 3)
('Zlin', 3)
('Kladno', 2)
('Liberec', 2)
('Most', 2)
('Olomouc', 2)
('Plzen', 2)
*/