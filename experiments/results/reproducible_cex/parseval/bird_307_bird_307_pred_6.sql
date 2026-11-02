-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__81a878', 'molecule_i_1', 't2__eb2aff');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't2__eb2aff');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 't2__eb2aff');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__b88ba8', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'siie5unw6k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'uo4nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '5bbp0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'yytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '72k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__1bb451', 'molecule_i_1', 'x1');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR000_2_3', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__42b8ea', 'molecule_i_1', 'tliqa1');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__81a878', 't1__81a878', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b88ba8', 'A', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'A', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_6', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't1__81a878', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__81a878', 'G', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__81a878', 'atom_id_7', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__81a878', 't1__b88ba8', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__81a878', 'atom_id_8', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__81a878', 'atom_id_9', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__81a878', 'atom_id_10', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__81a878', 'atom_id_11', 't1__42b8ea');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__81a878', 'atom_id_12', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__81a878', 'atom_id_2', 'TR000_2_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR000_2_3';

/*
Gold Result:
('t2__eb2aff',)
('t2__eb2aff',)
('a2ypuzhsrwbb',)
('hvdlttilbnpr',)
('hvdlttilbnpr',)
('hvdlttilbnpr',)
('t2__eb2aff',)
('t2__eb2aff',)
('t2__eb2aff',)
('t2__eb2aff',)
('t2__eb2aff',)
('t2__eb2aff',)
('t2__eb2aff',)
('t2__eb2aff',)
*/

-- Prediction Query
SELECT DISTINCT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id OR T1.atom_id2 = T2.atom_id WHERE T1.bond_id = 'TR000_2_3';

/*
Prediction Result:
('t2__eb2aff',)
('a2ypuzhsrwbb',)
('hvdlttilbnpr',)
('siie5unw6k',)
('00t5c4ecigc',)
('um5',)
('uo4nrqrofqy',)
('5bbp0',)
('72k',)
*/