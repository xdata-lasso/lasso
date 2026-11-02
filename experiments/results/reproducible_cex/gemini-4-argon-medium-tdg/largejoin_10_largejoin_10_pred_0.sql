-- Schema DDL
CREATE TABLE RA (A1 TEXT(5) PRIMARY KEY, B TEXT(5));

CREATE TABLE RB (A2 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RA (A1));

CREATE TABLE RC (A3 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RB (A2));

CREATE TABLE RD (A4 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RC (A3));

CREATE TABLE RE (A5 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RD (A4));

CREATE TABLE RF (A6 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RE (A5));

CREATE TABLE RG (A7 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RF (A6));

CREATE TABLE RH (A8 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RG (A7));

CREATE TABLE RI (A9 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RH (A8));

CREATE TABLE RJ (A10 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RI (A9));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. HAVING COUNT(RA.B) > 3 boundary condition: 'b1' has 2 rows in RA * 2 rows in RB = 4 rows (>3, included).
-- 2. HAVING COUNT(RA.B) > 3 boundary condition: 'b2' has 1 row in RA * 2 rows in RB = 2 rows (<=3, excluded).
-- 3. COUNT(RA.B) vs COUNT(*): 'NULL' has 2 rows in RA * 2 rows in RB = 4 rows, but COUNT(RA.B) = 0 (excluded).
-- 4. CROSS JOIN vs INNER/NATURAL JOIN: RB has a row with B=NULL and a row referencing 'a3' (so 'a1' and 'a2' are unreferenced in RB).
-- 5. GROUP BY RA.B vs GROUP BY RA.A1: 'b1' is split across two different A1 keys ('a1', 'a2'), each only having 2 rows in the cross product (<3 if grouped by A1).
INSERT INTO RA (A1, B) VALUES ('a1', 'b1');
INSERT INTO RA (A1, B) VALUES ('a2', 'b1');
INSERT INTO RA (A1, B) VALUES ('a3', 'b2');
INSERT INTO RA (A1, B) VALUES ('a4', NULL);
INSERT INTO RA (A1, B) VALUES ('a5', NULL);
INSERT INTO RB (A2, B) VALUES ('b_1', 'a3');
INSERT INTO RB (A2, B) VALUES ('b_2', NULL);
INSERT INTO RC (A3, B) VALUES ('c_1', 'b_1');
INSERT INTO RD (A4, B) VALUES ('d_1', 'c_1');
INSERT INTO RE (A5, B) VALUES ('e_1', 'd_1');
INSERT INTO RF (A6, B) VALUES ('f_1', 'e_1');
INSERT INTO RG (A7, B) VALUES ('g_1', 'f_1');
INSERT INTO RH (A8, B) VALUES ('h_1', 'g_1');
INSERT INTO RI (A9, B) VALUES ('i_1', 'h_1');
INSERT INTO RJ (A10, B) VALUES ('j_1', 'i_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RA.B FROM RA CROSS JOIN RB CROSS JOIN RC CROSS JOIN RD CROSS JOIN RE CROSS JOIN RF CROSS JOIN RG CROSS JOIN RH CROSS JOIN RI CROSS JOIN RJ GROUP BY RA.B HAVING COUNT(RA.B) > 3;

/*
Gold Result:
('b1',)
*/

-- Prediction Query
SELECT RA.B FROM RA WHERE 1 = 2;

/*
Prediction Result:
*/