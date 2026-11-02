-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAAAA4', 't1__dfdd71', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('IAAAAA4', 't1__30e0d9', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('EAAAAA4', 'A', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('CAAAAA4', 'A', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__dfdd71', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAAAAA4', 't1__dfdd71', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAAAAAA', 't1__dfdd71', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 't1__30e0d9', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('4', 't1__dfdd71', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't1__30e0d9', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__30e0d9', 't1__993ab7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@?AAAA4', '@', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('BEAAAA4', 'H', 'e4');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__dfdd71', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__30e0d9', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__478a22', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, -1) = '4' AND LENGTH(T1.atom_id) = 7;

/*
Gold Result:
('t1__993ab7',)
('gu7v',)
('e4',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, 7, 1) = '4';

/*
Prediction Result:
('t1__993ab7',)
('t1__993ab7',)
('gu7v',)
('e4',)
*/