-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR01227', 'TR012', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR01218', '=19', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR01221', 'TR012', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('c20', 'TR012', 'c32');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR01218', 'TR01227', 'c20');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR01218', 'TR01218', 'TR01221');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=19', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR012', '=28');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.molecule_id = 'TR012' AND T3.bond_type = '=' AND T1.element = 'c';

/*
Gold Result:
('TR01227',)
*/

-- Prediction Query
SELECT DISTINCT atom.atom_id FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.molecule_id = 'TR012' AND atom.element = 'c' AND bond.bond_type = '=';

/*
Prediction Result:
*/