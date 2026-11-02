-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__093801', 'molecule_i_1', 't1__497e00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__257704', 'molecule_i_1', 't1__497e00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't1__497e00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 't1__497e00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'sr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 't1__497e00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'nprmdposii');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 't1__497e00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', '6klfa9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__2a7bae', 'molecule_i_1', 't1__497e00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 't1__497e00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 't1__497e00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 't1__497e00');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'bbp02eut');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'ytoo3o9');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_2_4', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__3d1aca', 'molecule_i_1', '52zb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__9060ef', 'molecule_i_1', 'nrqrofqy');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__093801', 't1__093801', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__093801', 'atom_id_3', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_3', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_8', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_9', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_11', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_7', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2a7bae', 'atom_id_4', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2a7bae', 'atom_id_8', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2a7bae', 'atom_id_10', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2a7bae', 't1__257704', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2a7bae', 't2__2a7bae', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2a7bae', 'atom_id_16', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__093801', 'atom_id_4', 't2__3d1aca');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__093801', 'atom_id_11', 't2__9060ef');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2a7bae', 'atom_id_17', 't2__3d1aca');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2a7bae', 'O', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__093801', 'atom_id_14', 'TR001_2_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__093801', 'atom_id_18', 'TR001_2_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_2_4';

/*
Gold Result:
('t1__497e00',)
('sr',)
*/

-- Prediction Query
SELECT a.element FROM connected AS c INNER JOIN atom AS a ON c.atom_id = a.atom_id WHERE c.bond_id = 'TR001_2_4';

/*
Prediction Result:
('t1__497e00',)
('t1__497e00',)
('sr',)
('sr',)
('sr',)
('sr',)
('sr',)
('sr',)
('t1__497e00',)
('t1__497e00',)
('t1__497e00',)
('t1__497e00',)
('t1__497e00',)
('t1__497e00',)
('t1__497e00',)
('t1__497e00',)
('t1__497e00',)
*/