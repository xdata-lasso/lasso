-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR000', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_4', 'TR000', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_4', 'TR000', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_5', 'TR000', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_1', 'TR000', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('4R000_1', 'TR000', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR00_4', 'TR000', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR0000_4', 'TR000', 'f');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_41', 'TR000', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_44', 'TR000', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_4', 'TR002', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR003_4', 'TR003', 'i');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, -1) = '4' AND LENGTH(T1.atom_id) = 7;

/*
Gold Result:
('c',)
*/

-- Prediction Query
SELECT element, COUNT(*) AS count FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, 7, 1) = '4' GROUP BY T1.element;

/*
Prediction Result:
('br', 1)
('c', 2)
('cl', 1)
*/