-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__1539ab', 'molecule_i_1', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', '4h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'sr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'p6luhvdlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__e060da', 'molecule_i_1', '5u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'a9000t5c4eci');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', '6nium52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'rqrofqyp5s');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'iqa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'ytoo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'lex');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_3_4', 'molecule_i_1', 'gu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__dc15ab', 'molecule_i_1', '02eu');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1539ab', 't1__1539ab', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__1539ab', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'A', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 't1__1539ab', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'C', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e060da', 'C', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e060da', 'A', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e060da', 't2__e060da', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e060da', 'atom_id_8', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e060da', 't1__1539ab', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e060da', 'atom_id_9', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e060da', 'O', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e060da', 'atom_id_10', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1539ab', 'atom_id_11', 't2__dc15ab');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e060da', 'atom_id_12', 't2__dc15ab');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e060da', 'atom_id_13', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1539ab', 'atom_id_8', 'TR001_3_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.element) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_3_4';

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(atom_id) FROM connected WHERE bond_id = 'TR001_3_4';

/*
Prediction Result:
(15,)
*/