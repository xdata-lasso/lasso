-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR006', 't2__85b041');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__64ac21', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__3039ca', 'TR006', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__79556a', 'TR006', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'TR006', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR006', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'TR006', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'TR006', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'TR006', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', '?', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 'I', 't1__16e1d0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('H', 'C', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id), T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' AND T2.molecule_id = 'TR006' GROUP BY T2.label;

/*
Gold Result:
(7, 't2__85b041')
*/

-- Prediction Query
SELECT COUNT(CASE WHEN T1.bond_type = 'double' THEN 1 END) AS double_bond_count, T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR006' GROUP BY T2.label;

/*
Prediction Result:
(0, 't2__85b041')
*/