-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests handling of NULL 'element' values and case/substring sensitivity on 'bond_id' (e.g., LIKE vs =).
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('M1', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A1', 'M1', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A2', 'M1', 'i');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A3', 'M1', 'zn');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_2_4', 'M1', '1');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('tr001_2_4', 'M1', '1');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_2_4_1', 'M1', '1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A1', 'A2', 'TR001_2_4');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A2', 'A3', 'tr001_2_4');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A3', 'A1', 'TR001_2_4_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_2_4';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT COALESCE(T2.element, T4.element) AS element FROM connected AS T1 LEFT JOIN atom AS T2 ON T1.atom_id = T2.atom_id LEFT JOIN atom AS T4 ON T1.atom_id2 = T4.atom_id WHERE T1.bond_id = 'TR001_2_4';

/*
Prediction Result:
('i',)
*/