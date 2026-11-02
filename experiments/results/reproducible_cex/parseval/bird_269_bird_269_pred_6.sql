-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__a3edbb', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'A', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'G', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', '_', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'G', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'G', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'O', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', '_', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', '?', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__a3edbb', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__a3edbb', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't3__48f4c8', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__a3edbb', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't3__48f4c8', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__a3edbb', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't3__48f4c8', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 't3__48f4c8', 'i');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__a3edbb', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'rwbbp6luhvd');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', 'tti');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t3__48f4c8', 'bnp');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__3ab5bc', 'a9000t5c4eci');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t3__d1f34e', 't1__a3edbb', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't3__48f4c8', 'mdpos');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't3__48f4c8', 'ie5');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't3__48f4c8', 'nw6klf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.bond_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T1.element = 'i';

/*
Gold Result:
(17,)
*/

-- Prediction Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'i';

/*
Prediction Result:
(0,)
*/