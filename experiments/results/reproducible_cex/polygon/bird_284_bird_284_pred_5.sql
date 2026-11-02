-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c25', 'te24', 'te');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c27', 'te26', 'c');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('c17', 'te24', 'te22');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('te16', 'te24', 'c23');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('c27', 'c25', 'te16');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('c25', 'c27', 'c17');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('te24', 'te24');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('te26', 'te24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
('c23',)
('te22',)
*/

-- Prediction Query
SELECT DISTINCT bond.bond_type FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.element = 'c';

/*
Prediction Result:
('c23',)
*/