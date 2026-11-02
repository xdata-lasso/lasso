-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('#21', 'TR04126', '#27');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR04120', 'TR447', 'TR44728');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR44719', 'TR447', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('#18', 'TR447', '#');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('#21', 'TR04120', 'TR44719');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR04120', '#21', '#18');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR04126', '#21');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR447', '#21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.atom_id, T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '#' AND T3.molecule_id = 'TR447';

/*
Gold Result:
('#21', 'TR04120')
('TR04120', '#21')
*/

-- Prediction Query
SELECT DISTINCT c.atom_id, c.atom_id2 FROM connected AS c INNER JOIN bond AS b ON c.bond_id = b.bond_id WHERE b.molecule_id = 'TR041' AND b.bond_type = '#';

/*
Prediction Result:
*/