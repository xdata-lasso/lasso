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
INSERT INTO "ra" ("a1", "b") VALUES ('purpose', 'face');
INSERT INTO "ra" ("a1", "b") VALUES ('brother', 'face');
INSERT INTO "ra" ("a1", "b") VALUES ('ago', 'face');
INSERT INTO "ra" ("a1", "b") VALUES ('site', 'face');
INSERT INTO "rb" ("a2", "b") VALUES ('election', 'purpose');
INSERT INTO "rb" ("a2", "b") VALUES ('dog', 'purpose');
INSERT INTO "rb" ("a2", "b") VALUES ('chair', 'purpose');
INSERT INTO "rb" ("a2", "b") VALUES ('since', 'purpose');
INSERT INTO "rc" ("a3", "b") VALUES ('blue', 'election');
INSERT INTO "rd" ("a4", "b") VALUES ('require', 'blue');
INSERT INTO "re" ("a5", "b") VALUES ('sit', 'require');
INSERT INTO "rf" ("a6", "b") VALUES ('wait', 'sit');
INSERT INTO "rg" ("a7", "b") VALUES ('offer', 'wait');
INSERT INTO "rh" ("a8", "b") VALUES ('begin', 'offer');
INSERT INTO "ri" ("a9", "b") VALUES ('performance', 'begin');
INSERT INTO "rj" ("a10", "b") VALUES ('knowledge', 'performance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RA.B FROM RA CROSS JOIN RB CROSS JOIN RC CROSS JOIN RD CROSS JOIN RE CROSS JOIN RF CROSS JOIN RG CROSS JOIN RH CROSS JOIN RI CROSS JOIN RJ GROUP BY RA.B HAVING COUNT(RA.B) > 3;

/*
Gold Result:
('face',)
*/

-- Prediction Query
SELECT RA.B FROM RA WHERE 1 = 2;

/*
Prediction Result:
*/