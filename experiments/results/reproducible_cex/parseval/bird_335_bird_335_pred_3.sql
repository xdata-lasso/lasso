-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__6d3628', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'A', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'Q', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'O', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'G', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't1__6d3628', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__6d3628', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__6d3628', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__6d3628', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't1__6d3628', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 't1__6d3628', 't1__84dd0e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__6d3628', 'o');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__6d3628', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 'hria2ypuzhs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__6d3628', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 'C', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 't1__6d3628', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 't1__6d3628', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 't1__6d3628', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 't1__6d3628', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__6d3628', 't2__6a899c');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 't1__6d3628', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 't1__6d3628', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=' AND T1.element = 'o';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT atom.molecule_id) FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.element = 'o' AND bond.bond_type = '=';

/*
Prediction Result:
(0,)
*/