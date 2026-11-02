-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests empty result set (count = 0) when table has rows but none match the predicate
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR004', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR004_18', 'TR004', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR004_19', 'TR004', 'h');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR004_18_19', 'TR004', '1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR004_18', 'TR004_19', 'TR004_18_19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.bond_id) FROM connected AS T WHERE SUBSTRING(T.atom_id, -2) = '19';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(bond_id) FROM connected WHERE atom_id LIKE 'TR%_19' OR atom_id2 LIKE 'TR%_19';

/*
Prediction Result:
(1,)
*/