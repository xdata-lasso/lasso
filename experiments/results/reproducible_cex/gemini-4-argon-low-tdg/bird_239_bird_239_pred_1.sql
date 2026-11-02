-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests COUNT(bond_id) vs COUNT(*) when bond_id is NULL, and COUNT(bond_id) vs COUNT(DISTINCT bond_id) when bond_id has duplicates.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001', '+');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_19', 'TR001', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_1', 'TR001', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_2', 'TR001', 'o');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_3', 'TR001', 'n');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B1', 'TR001', '1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_19', 'TR001_1', 'B1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_19', 'TR001_2', 'B1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_19', 'TR001_3', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.bond_id) FROM connected AS T WHERE SUBSTRING(T.atom_id, -2) = '19';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.bond_id) AS connection_count FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.atom_id LIKE 'TR%_19';

/*
Prediction Result:
(1,)
*/