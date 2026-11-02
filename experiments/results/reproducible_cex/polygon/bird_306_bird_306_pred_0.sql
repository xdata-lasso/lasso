-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('#33', '#21', '#37');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('#36', '#21', '#30');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('#24', '#21', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('#23', '#21', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('#33', '#36', '#24');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('#21', '#38');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('#22', '#21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('#21', '#30')
('#21', '#37')
*/

-- Prediction Query
SELECT T3.label, T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id INNER JOIN bond AS T4 ON T2.bond_id = T4.bond_id WHERE T4.bond_type = '#' GROUP BY T3.label, T1.element;

/*
Prediction Result:
('#38', '#37')
*/