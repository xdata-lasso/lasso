-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('te24', 'te26', 'te');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('te32', 'te31', 'te');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('te19', 'te26', 'te27');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('te25', 'te26', 'te28');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('te32', 'te24', 'te19');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('te32', 'te32', 'te19');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('te31', 'te32');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('te26', 'te32');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
('te27',)
('te28',)
*/

-- Prediction Query
SELECT DISTINCT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T1.element = 'te';

/*
Prediction Result:
('te27',)
*/