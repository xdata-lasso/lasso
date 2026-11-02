-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__5c8c92', 'molecule_i_1', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', '4h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'posiie5unw6k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 'a9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__7993e1', 'molecule_i_1', '0t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'zbuo4nrqrof');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'bbp02eut');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'oo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'lex');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_3_4', 'molecule_i_1', 'gu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__4d1ed2', 'molecule_i_1', '1');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5c8c92', 't1__5c8c92', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't1__5c8c92', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_6', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'Q', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7993e1', 'A', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7993e1', 't2__7993e1', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7993e1', 'C', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7993e1', 'atom_id_6', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7993e1', 'atom_id_9', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7993e1', 'G', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7993e1', 'Q', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7993e1', 'atom_id_10', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5c8c92', 'C', 't2__4d1ed2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__7993e1', 'atom_id_11', 't2__4d1ed2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__5c8c92', 'atom_id_12', 'TR001_3_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.element) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_3_4';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT element) FROM (SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_3_4' UNION SELECT T3.element FROM atom AS T3 INNER JOIN connected AS T4 ON T3.atom_id = T4.atom_id2 WHERE T4.bond_id = 'TR001_3_4') AS combined_elements;

/*
Prediction Result:
(10,)
*/