-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR02426', NULL, 'TR02428');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR02428', 'TR024', '=27');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR02418', '=19', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=17', 'TR024', '=');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR02428', 'TR02426', 'TR02418');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR02428', 'TR02428', '=17');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR024', 'TR02428');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=19', 'TR02428');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR024' AND T2.bond_type = '=';

/*
Gold Result:
('=27',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '=' AND T1.molecule_id = 'TR024';

/*
Prediction Result:
('=27',)
('=27',)
*/