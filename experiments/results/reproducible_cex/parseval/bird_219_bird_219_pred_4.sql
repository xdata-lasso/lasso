-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('bon_09833f', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('mol_ee6ff6', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('E', '+');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bon_cff9ef', 'bon_09833f', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'bon_09833f', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', '@', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('H', 'D', 'bon_2f521a');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'H', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 'B', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'C', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'E', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T2.label = '+' THEN T2.molecule_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN molecule.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(bond.bond_id) AS percent FROM bond INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE bond.bond_type = '#';

/*
Prediction Result:
(66.66666666666667,)
*/