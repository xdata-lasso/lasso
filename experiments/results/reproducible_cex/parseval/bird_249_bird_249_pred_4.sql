-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__1af901', 'molecule_i_1', 't2__48f4e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't2__48f4e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 't2__48f4e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 't2__48f4e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 't2__48f4e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'tti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'molecule_i_1', 't2__48f4e1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'siie');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'klfa9000t');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', '4ecigce376n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__d98054', 'molecule_i_1', 'fqyp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'p');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR144_8_19', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__9e1b9e', 'molecule_i_1', '52zbuo4nrq');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1af901', 't1__1af901', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 'A', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_2', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_7', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__1af901', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1af901', 'C', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1af901', 'G', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1af901', 'atom_id_9', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1af901', 'I', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1af901', 'atom_id_10', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1af901', 'atom_id_11', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1af901', 'O', 't1__9e1b9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1af901', 'atom_id_13', 'TR144_8_19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR144_8_19';

/*
Gold Result:
('t2__48f4e1',)
('t2__48f4e1',)
('a2ypuzhsrwbb',)
('t2__48f4e1',)
('t2__48f4e1',)
('t2__48f4e1',)
('t2__48f4e1',)
('t2__48f4e1',)
('t2__48f4e1',)
('t2__48f4e1',)
('t2__48f4e1',)
('t2__48f4e1',)
('t2__48f4e1',)
*/

-- Prediction Query
SELECT T1.element AS atom1_element, T2.element AS atom2_element FROM connected AS C INNER JOIN atom AS T1 ON C.atom_id = T1.atom_id INNER JOIN atom AS T2 ON C.atom_id2 = T2.atom_id WHERE C.bond_id = 'TR144_8_19';

/*
Prediction Result:
('t2__48f4e1', 't2__48f4e1')
('t2__48f4e1', 't2__48f4e1')
('a2ypuzhsrwbb', 't2__48f4e1')
('t2__48f4e1', 't2__48f4e1')
('t2__48f4e1', 'tti')
('t2__48f4e1', 't2__48f4e1')
('t2__48f4e1', 'a2ypuzhsrwbb')
('t2__48f4e1', 't2__48f4e1')
('t2__48f4e1', 'siie')
('t2__48f4e1', 't2__48f4e1')
('t2__48f4e1', 'klfa9000t')
('t2__48f4e1', '4ecigce376n')
('t2__48f4e1', 'p')
*/