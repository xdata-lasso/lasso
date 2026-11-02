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
INSERT INTO "ra" ("a1", "b") VALUES ('value', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('A', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('C', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_5', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_9', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_10', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_11', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_12', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_13', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_14', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_15', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_16', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_17', '@');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_18', '@');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_19', '@');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_20', '@');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_21', '@');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_22', '@');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_23', '@');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_24', '@');

INSERT INTO "ra" ("a1", "b") VALUES ('O', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_25', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_28', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('G', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_30', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('_', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_33', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19', 'ra__1ddbde');

INSERT INTO "ra" ("a1", "b") VALUES ('@', '@');

INSERT INTO "ra" ("a1", "b") VALUES ('`', '@');

INSERT INTO "ra" ("a1", "b") VALUES ('B', 'G');

INSERT INTO "ra" ("a1", "b") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20', 'ra__d4a775');

INSERT INTO "ra" ("a1", "b") VALUES ('D', 'H');

INSERT INTO "ra" ("a1", "b") VALUES ('a1_52', 'val_1');

-- Inserting into table: rb --
INSERT INTO "rb" ("a2", "b") VALUES ('ra__1ddbde', 'value_1_2_3');

INSERT INTO "rb" ("a2", "b") VALUES ('a2_2', 'value_1_2_3_4');

INSERT INTO "rb" ("a2", "b") VALUES ('A', 'A');

INSERT INTO "rb" ("a2", "b") VALUES ('rb__adc132', 'a1_14');

INSERT INTO "rb" ("a2", "b") VALUES ('@', 'value_1_2_3_4_5_6_7_8_9_10_11');

INSERT INTO "rb" ("a2", "b") VALUES ('Q', 'value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18');

INSERT INTO "rb" ("a2", "b") VALUES ('G', 'value_1_2_3_4_5_6_7_8_9_10_11');

INSERT INTO "rb" ("a2", "b") VALUES ('H', 'value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RA.B FROM RA INNER JOIN RB ON (RA.B = RB.A2) GROUP BY RA.B HAVING COUNT(RA.B) > 3;

/*
Gold Result:
('@',)
('G',)
('ra__1ddbde',)
*/

-- Prediction Query
SELECT RA.B FROM RA WHERE 1 = 2;

/*
Prediction Result:
*/