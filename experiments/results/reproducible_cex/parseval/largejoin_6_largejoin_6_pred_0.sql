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
-- Inserting into table: ra --
INSERT INTO "ra" ("a1", "b") VALUES ('value', 'ra__3cf9e9');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1', 'ra__3cf9e9');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2', 'ra__3cf9e9');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3', 'ra__3cf9e9');

INSERT INTO "ra" ("a1", "b") VALUES ('A', 'ra__3cf9e9');

INSERT INTO "ra" ("a1", "b") VALUES ('C', 'ra__3cf9e9');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_5', 'ra__3cf9e9');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4', 'ra__3cf9e9');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_9', NULL);

INSERT INTO "ra" ("a1", "b") VALUES ('a1_10', NULL);

INSERT INTO "ra" ("a1", "b") VALUES ('a1_11', NULL);

INSERT INTO "ra" ("a1", "b") VALUES ('a1_12', NULL);

INSERT INTO "ra" ("a1", "b") VALUES (']', '4cf81');

INSERT INTO "ra" ("a1", "b") VALUES ('@', 'ra__2171ab');

INSERT INTO "ra" ("a1", "b") VALUES ('K', 'ra__2171ab');

INSERT INTO "ra" ("a1", "b") VALUES ('`', 'ra__2171ab');

INSERT INTO "ra" ("a1", "b") VALUES ('I', 'ra__2171ab');

INSERT INTO "ra" ("a1", "b") VALUES ('D', '4cf81');

INSERT INTO "ra" ("a1", "b") VALUES ('B', '4cf81');

INSERT INTO "ra" ("a1", "b") VALUES ('b', 'ra__902e5f');

INSERT INTO "ra" ("a1", "b") VALUES ('E', 'ra__902e5f');

INSERT INTO "ra" ("a1", "b") VALUES ('H', NULL);

INSERT INTO "ra" ("a1", "b") VALUES ('c', NULL);

INSERT INTO "ra" ("a1", "b") VALUES ('F', NULL);

INSERT INTO "ra" ("a1", "b") VALUES ('a', NULL);

INSERT INTO "ra" ("a1", "b") VALUES ('G', NULL);

INSERT INTO "ra" ("a1", "b") VALUES ('!', NULL);

INSERT INTO "ra" ("a1", "b") VALUES ('"', NULL);

-- Inserting into table: rb --
INSERT INTO "rb" ("a2", "b") VALUES ('!', '`');

INSERT INTO "rb" ("a2", "b") VALUES ('H', 'C');

INSERT INTO "rb" ("a2", "b") VALUES ('?', '`');

INSERT INTO "rb" ("a2", "b") VALUES ('@', 'a1_10');

INSERT INTO "rb" ("a2", "b") VALUES ('A', 'a1_12');

INSERT INTO "rb" ("a2", "b") VALUES ('I', 'a1_12');

INSERT INTO "rb" ("a2", "b") VALUES ('B', 'a1_9');

INSERT INTO "rb" ("a2", "b") VALUES ('K', 'value_1');

INSERT INTO "rb" ("a2", "b") VALUES ('C', 'value_1_2_3');

INSERT INTO "rb" ("a2", "b") VALUES ('D', 'a1_10');

INSERT INTO "rb" ("a2", "b") VALUES ('F', 'C');

INSERT INTO "rb" ("a2", "b") VALUES ('E', 'B');

INSERT INTO "rb" ("a2", "b") VALUES ('"', 'D');

INSERT INTO "rb" ("a2", "b") VALUES ('G', 'a1_5');

INSERT INTO "rb" ("a2", "b") VALUES ('Q', 'b');

INSERT INTO "rb" ("a2", "b") VALUES ('b', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RA.B FROM RA CROSS JOIN RB GROUP BY RA.B HAVING COUNT(RA.B) > 3;

/*
Gold Result:
('4cf81',)
('ra__2171ab',)
('ra__3cf9e9',)
('ra__902e5f',)
*/

-- Prediction Query
SELECT RA.B FROM RA WHERE 1 = 2;

/*
Prediction Result:
*/