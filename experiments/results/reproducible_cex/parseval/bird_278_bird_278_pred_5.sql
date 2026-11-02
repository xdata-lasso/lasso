-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__5f4b99', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__608692', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '-');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__5f4b99', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 'A', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'O', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'G', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 'O', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 't1__5f4b99', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't1__5f4b99', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 't1__5f4b99', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't1__5f4b99', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__5f4b99', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 't1__5f4b99', 't1__43d89c');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 't1__5f4b99', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', '@', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' AND T1.bond_type = '-';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '-' AND T1.label = '-';

/*
Prediction Result:
(7,)
*/