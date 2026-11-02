-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t_s_5fa12b', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't_s_5fa12b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 't_s_5fa12b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't_s_5fa12b', 't_s_2fb55c');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't_s_5fa12b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 't_s_5fa12b', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 't_s_5fa12b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 't_s_5fa12b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('H', 't_s_5fa12b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('W', 't_s_5fa12b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('D', 't_s_5fa12b', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('`', 't_s_5fa12b', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=' ORDER BY T.molecule_id LIMIT 5;

/*
Gold Result:
('t_s_5fa12b',)
*/

-- Prediction Query
SELECT DISTINCT molecule.label FROM bond INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE bond.bond_type = '=' ORDER BY molecule.molecule_id ASC, molecule.label NULLS LAST LIMIT 5;

/*
Prediction Result:
('5k5swwqcgs',)
*/