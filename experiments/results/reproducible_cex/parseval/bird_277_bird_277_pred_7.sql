-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__4b31a2', 'molecule_i_1', 't1__19be6f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__8c1d42', 'molecule_i_1', 't1__19be6f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'ypuzhsrw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 't1__19be6f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'p6luhvdlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 't1__19be6f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'molecule_i_1', 't1__19be6f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'posiie5unw6k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__aed655', 'molecule_i_1', 't1__19be6f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'c4ecigce');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'rofqyp5s5b');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR005_16_26', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__7ce42c', 'molecule_i_1', 'u');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b31a2', 't1__4b31a2', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b31a2', 't1__8c1d42', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b31a2', 'atom_id_3', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__4b31a2', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__8c1d42', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_8', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aed655', 't1__8c1d42', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aed655', 't1__4b31a2', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aed655', 'I', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aed655', 'atom_id_10', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aed655', 't2__aed655', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aed655', 'atom_id_11', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b31a2', 'atom_id_11', 't2__7ce42c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aed655', 'atom_id_8', 'TR005_16_26');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4b31a2', 'atom_id_12', 'TR005_16_26');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR005_16_26';

/*
Gold Result:
('t1__19be6f',)
('t1__19be6f',)
('t1__19be6f',)
('p6luhvdlttil',)
('p6luhvdlttil',)
('p6luhvdlttil',)
('t1__19be6f',)
('t1__19be6f',)
('t1__19be6f',)
('t1__19be6f',)
('t1__19be6f',)
('t1__19be6f',)
('t1__19be6f',)
('t1__19be6f',)
*/

-- Prediction Query
SELECT atom.element FROM bond INNER JOIN connected ON bond.bond_id = connected.bond_id INNER JOIN atom ON connected.atom_id = atom.atom_id WHERE bond.bond_id = 'TR000_1_2' UNION SELECT atom.element FROM bond INNER JOIN connected ON bond.bond_id = connected.bond_id INNER JOIN atom ON connected.atom_id2 = atom.atom_id WHERE bond.bond_id = 'TR000_1_2';

/*
Prediction Result:
*/