-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__bd0b6b', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'C', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', '@', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'A', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', '@', 'tti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'A', 'bnp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', '@', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'A', 'ie5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', '@', 'nw6klf');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't1__bd0b6b', 'a9000t5c4eci');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't2__7b4e95', 'gce376nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__7b4e95', 'zbuo4nrqrof');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__bd0b6b', 'qyp5s5bbp0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't1__bd0b6b', '2eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__bd0b6b', 'ytoo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__bd0b6b', 'l7');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__bd0b6b', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'rwbbp6luhvd');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__7b4e95', '+');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__bd0b6b', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 'A', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'O', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 'O', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'O', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't1__bd0b6b', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't1__bd0b6b', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 't2__7b4e95', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 't2__7b4e95', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 't1__bd0b6b', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 't2__7b4e95', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 't2__7b4e95', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_17', '@', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_18', 't1__bd0b6b', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(single_bond_count) FROM (SELECT T3.molecule_id, COUNT(T1.bond_type) AS single_bond_count FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN molecule AS T3 ON T3.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T3.label = '+' GROUP BY T3.molecule_id) AS subquery;

/*
Gold Result:
(19.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.bond_type = '-' THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT T1.molecule_id) AS average FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+';

/*
Prediction Result:
(4.5,)
*/