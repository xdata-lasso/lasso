-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR00014', NULL, 'TR000');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR00013', 'TR000', 'TR000');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00019', 'TR000', 'TR00022');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00021', 'TR000', 'TR00022');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR00013', 'TR00013', 'TR00021');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR00014', 'TR00014', 'TR00021');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000', 'TR00020');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.bond_type FROM bond AS T WHERE T.molecule_id = 'TR000';

/*
Gold Result:
('TR00022',)
*/

-- Prediction Query
SELECT T2.bond_type FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR000';

/*
Prediction Result:
('TR00022',)
('TR00022',)
*/