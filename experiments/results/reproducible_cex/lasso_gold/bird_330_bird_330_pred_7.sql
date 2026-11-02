-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('sense', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('offer', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('list', '+');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('rate', 'sense', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('kind', 'offer', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('perform', 'list', 'h');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('science', 'sense', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('discussion', 'offer', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('fall', 'list', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T2.element = 'h';

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN molecule.label = '+' THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT molecule.molecule_id)) * 100.0 AS percentage FROM atom INNER JOIN bond ON atom.molecule_id = bond.molecule_id INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE atom.element = 'h' AND bond.bond_type = '#';

/*
Prediction Result:
(66.66666666666666,)
*/