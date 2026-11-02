-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR44722', 'TR04129', '#30');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR04123', NULL, 'TR44722');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('#24', 'TR447', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('#21', 'TR447', '#33');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR44722', 'TR44722', '#24');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR44722', 'TR04123', '#24');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR447', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR04129', 'TR44722');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.atom_id, T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '#' AND T3.molecule_id = 'TR447';

/*
Gold Result:
('TR44722', 'TR44722')
('TR44722', 'TR04123')
*/

-- Prediction Query
SELECT DISTINCT c.atom_id, c.atom_id2 FROM molecule AS m INNER JOIN bond AS b ON m.molecule_id = b.molecule_id INNER JOIN connected AS c ON b.bond_id = c.bond_id WHERE m.molecule_id = 'TR041' AND b.bond_type = '#';

/*
Prediction Result:
*/