-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c25', 'c27', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('te16', 'te18', 'te24');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('c17', 'te18', 'c23');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('te26', 'c27', 'te28');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('te18', 'c27');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('c27', 'c27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT b.bond_type FROM atom AS a JOIN bond AS b ON a.molecule_id = b.molecule_id WHERE a.element = 'c';

/*
Prediction Result:
('te28',)
*/