-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't1__3c6210');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__42f8e9', 'molecule_i_1', 't1__3c6210');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 't1__3c6210');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 't1__3c6210');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'l');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'molecule_i_1', 't1__3c6210');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'nprmdposii');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '6klfa9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', '0t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 't1__3c6210');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__b85887', 'molecule_i_1', '5bbp0');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_2_4', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__a5173a', 'molecule_i_1', '4nrq');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__b22c1d', 'molecule_i_1', 'fqyp');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_3', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'A', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'Q', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 't1__42f8e9', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'Q', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_7', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'atom_id_3', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'atom_id_9', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_10', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_11', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_9', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_12', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'A', 't2__a5173a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'atom_id_10', 't2__b22c1d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__b85887', 'atom_id_11', 't2__a5173a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__b85887', 't2__b85887', 't2__b22c1d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'G', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'atom_id_3', 'TR001_2_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_2_4';

/*
Gold Result:
('t1__3c6210',)
('b',)
*/

-- Prediction Query
SELECT DISTINCT "atom"."element" FROM "connected" INNER JOIN "atom" ON "connected"."atom_id" = "atom"."atom_id" OR "connected"."atom_id2" = "atom"."atom_id" WHERE "connected"."bond_id" = 'TR001_2_4';

/*
Prediction Result:
('t1__3c6210',)
('a2y',)
('b',)
('l',)
('nprmdposii',)
('6klfa9',)
('0t5c4ecigc',)
('um5',)
*/