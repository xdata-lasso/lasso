-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c20', '=22', '=28');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=34', 'TR012', 'c');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR01221', '=22', 'TR01233');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('c23', 'TR012', '=');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=34', 'c20', 'c23');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=34', '=34', 'c23');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR012', 'TR01230');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=22', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.molecule_id = 'TR012' AND T3.bond_type = '=' AND T1.element = 'c';

/*
Gold Result:
('=34',)
*/

-- Prediction Query
SELECT a.atom_id FROM atom AS a JOIN bond AS b ON a.molecule_id = b.molecule_id JOIN connected AS c ON b.bond_id = c.bond_id WHERE a.element = 'c' AND b.bond_type = '=' AND a.molecule_id = 'TR012';

/*
Prediction Result:
('=34',)
('=34',)
*/