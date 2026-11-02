-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__b0dc91', 'molecule_i_1', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', '4h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'posiie5unw6k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__25d422', 'molecule_i_1', '9000t5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', '4nrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'iqa');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_3_4', 'molecule_i_1', 'gu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__f5d874', 'molecule_i_1', 'qyp5s5bbp0');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b0dc91', 't1__b0dc91', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't1__b0dc91', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_6', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__b0dc91', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__25d422', 'A', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__25d422', 'atom_id_6', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__25d422', 't1__b0dc91', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__25d422', 'O', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__25d422', 'Q', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__25d422', 'atom_id_8', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__25d422', 't2__25d422', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__25d422', 'atom_id_9', 'TR001_3_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b0dc91', 'Q', 't2__f5d874');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__25d422', 'atom_id_10', 't2__f5d874');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b0dc91', 't2__25d422', 'TR001_3_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.element) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_3_4';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.element) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id OR T1.atom_id2 = T2.atom_id WHERE T1.bond_id = 'TR001_3_4';

/*
Prediction Result:
(9,)
*/