-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t_s_3c08c8', 'molecule_i_1', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('D', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.bond_type = '#' THEN T.bond_id ELSE NULL END) AS REAL) * 100 / COUNT(T.bond_id) FROM bond AS T;

/*
Gold Result:
(88.88888888888889,)
*/

-- Prediction Query
SELECT CAST(COUNT(DISTINCT CASE WHEN bond.bond_type = '#' THEN bond.molecule_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT molecule.molecule_id) AS percentage FROM molecule INNER JOIN bond ON molecule.molecule_id = bond.molecule_id;

/*
Prediction Result:
(100.0,)
*/