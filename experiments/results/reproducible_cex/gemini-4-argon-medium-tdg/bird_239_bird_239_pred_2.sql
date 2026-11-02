-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests string pattern boundary conditions (exact match, prefix, middle, suffix, off-by-one suffix) and column swaps (atom_id vs atom_id2 vs bond_id)
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR002', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('19', 'TR002', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('19_TR002', 'TR002', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR019_1', 'TR002', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR002_190', 'TR002', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR002_119', 'TR002', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR002_20', 'TR002', 'c');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B_1', 'TR002', '1');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B_19', 'TR002', '2');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('19', 'TR002_20', 'B_1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR002_119', 'TR002_20', 'B_1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('19_TR002', 'TR002_20', 'B_1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR019_1', 'TR002_20', 'B_1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR002_190', 'TR002_20', 'B_1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR002_20', 'TR002_119', 'B_19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.bond_id) FROM connected AS T WHERE SUBSTRING(T.atom_id, -2) = '19';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(bond_id) FROM connected WHERE atom_id LIKE 'TR%_19';

/*
Prediction Result:
(1,)
*/