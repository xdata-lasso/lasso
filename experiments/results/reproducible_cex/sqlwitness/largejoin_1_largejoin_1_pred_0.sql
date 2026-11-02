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
INSERT INTO ra (a1, b) VALUES ('default2', 'default1'), ('default1', 'default1'), ('unique_2', 'default2'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'default2'), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', NULL), ('unique_10', NULL), ('unique_11', NULL), ('unique_12', 'default2'), ('unique_13', NULL);
INSERT INTO rb (a2, b) VALUES ('default2', 'unique_9'), ('default1', 'unique_4'), ('unique_2', NULL), ('unique_3', 'unique_9'), ('unique_4', 'default1'), ('unique_5', 'unique_10'), ('unique_6', 'unique_9'), ('unique_7', NULL), ('unique_8', 'unique_11'), ('unique_9', 'unique_9'), ('unique_10', 'unique_7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RA.B FROM RA INNER JOIN RB ON (RA.B = RB.A2) GROUP BY RA.B HAVING COUNT(RA.B) > 3;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT RA.B FROM RA WHERE 1 = 2;

/*
Prediction Result:
*/