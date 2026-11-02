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
INSERT INTO "rb" ("a2", "b") VALUES ('face', 'purpose');
INSERT INTO "rb" ("a2", "b") VALUES ('election', 'purpose');
INSERT INTO "rb" ("a2", "b") VALUES ('dog', 'purpose');
INSERT INTO "rb" ("a2", "b") VALUES ('chair', 'purpose');
INSERT INTO "rc" ("a3", "b") VALUES ('purpose', 'face');
INSERT INTO "rc" ("a3", "b") VALUES ('brother', 'face');
INSERT INTO "rc" ("a3", "b") VALUES ('ago', 'face');
INSERT INTO "rc" ("a3", "b") VALUES ('site', 'face');
INSERT INTO "rd" ("a4", "b") VALUES ('face', 'purpose');
INSERT INTO "rd" ("a4", "b") VALUES ('election', 'purpose');
INSERT INTO "rd" ("a4", "b") VALUES ('dog', 'purpose');
INSERT INTO "rd" ("a4", "b") VALUES ('chair', 'purpose');
INSERT INTO "re" ("a5", "b") VALUES ('purpose', 'face');
INSERT INTO "re" ("a5", "b") VALUES ('brother', 'face');
INSERT INTO "re" ("a5", "b") VALUES ('ago', 'face');
INSERT INTO "re" ("a5", "b") VALUES ('site', 'face');
INSERT INTO "rf" ("a6", "b") VALUES ('face', 'purpose');
INSERT INTO "rf" ("a6", "b") VALUES ('election', 'purpose');
INSERT INTO "rf" ("a6", "b") VALUES ('dog', 'purpose');
INSERT INTO "rf" ("a6", "b") VALUES ('chair', 'purpose');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RA.B FROM RA INNER JOIN RB ON (RA.B = RB.A2) INNER JOIN RC ON (RB.B = RC.A3) INNER JOIN RD ON (RC.B = RD.A4) INNER JOIN RE ON (RD.B = RE.A5) INNER JOIN RF ON (RE.B = RF.A6) GROUP BY RA.B HAVING COUNT(RA.B) > 3;

/*
Gold Result:
('face',)
*/

-- Prediction Query
SELECT RA.B FROM RA WHERE 1 = 2;

/*
Prediction Result:
*/