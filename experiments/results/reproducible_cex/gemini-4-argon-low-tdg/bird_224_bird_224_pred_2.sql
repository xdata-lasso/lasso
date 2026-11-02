-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in bond_id (kills unnecessary INNER JOIN to bond table or IS NOT NULL filters) and multiple distinct bond_id results.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_1', 'TR000', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_2', 'TR000', 'n');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_3', 'TR000', 'o');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('BOND_A', 'TR000', '1');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('BOND_B', 'TR000', '2');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_1', 'TR000_2', 'BOND_A');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_3', 'TR000_2', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_2', 'TR000_2', 'BOND_B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_id FROM connected AS T WHERE T.atom_id2 = 'TR000_2';

/*
Gold Result:
('BOND_A',)
(None,)
('BOND_B',)
*/

-- Prediction Query
SELECT bond.bond_id FROM bond INNER JOIN connected ON bond.bond_id = connected.bond_id WHERE connected.atom_id2 = 'TR000_2';

/*
Prediction Result:
('BOND_A',)
('BOND_B',)
*/