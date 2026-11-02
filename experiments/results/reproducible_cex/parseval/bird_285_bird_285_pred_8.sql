-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__aa7ebe', 'molecule_i_1', 't1__df87de');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't1__df87de');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 't1__df87de');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'uzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', '9000t5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'e376nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__f2cf53', 'molecule_i_1', 't1__df87de');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'fqyp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', '02eu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '1ryytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'x1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'au2dwy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'jsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'y9uxj4');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_10_11', 'molecule_i_1', '9n8c4pgu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'luhvdltti');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__fa7da6', 'molecule_i_1', '3pyu78d');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t3__e7ca0e', 'molecule_i_1', 'x58pz0f8je');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 't1__aa7ebe', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__aa7ebe', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'C', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'C', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 'atom_id_5', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'atom_id_5', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 'atom_id_7', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_7', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 'G', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f2cf53', 'atom_id_5', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f2cf53', 'atom_id_10', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 'O', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 'atom_id_11', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f2cf53', 'C', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f2cf53', 'atom_id_12', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 't2__f2cf53', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 'A', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f2cf53', 'atom_id_13', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f2cf53', 'O', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 'atom_id_10', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 'atom_id_14', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 'atom_id_15', 't2__fa7da6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f2cf53', 'atom_id_7', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__f2cf53', 'atom_id_16', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__aa7ebe', 'atom_id_17', 'TR001_10_11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_id = 'TR001_10_11';

/*
Gold Result:
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('uzhs',)
('dposiie5unw',)
('e376nium52',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
('t1__df87de',)
*/

-- Prediction Query
SELECT T1.element, T2.element FROM atom AS T1 INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id INNER JOIN atom AS T2 ON T2.atom_id = T3.atom_id2 WHERE T3.bond_id = 'TR001_10_11';

/*
Prediction Result:
('t1__df87de', 't1__df87de')
('t1__df87de', 't1__df87de')
('t1__df87de', 't1__df87de')
('uzhs', 't1__df87de')
('dposiie5unw', 'n')
('e376nium52', '9000t5c4ec')
('t1__df87de', 'n')
('t1__df87de', 'fqyp')
('t1__df87de', 'e376nium52')
('t1__df87de', '02eu')
('t1__df87de', 't1__df87de')
('t1__df87de', '1ryytoo')
('t1__df87de', 't1__df87de')
('t1__df87de', 't1__df87de')
('t1__df87de', 'x1')
('t1__df87de', 'e376nium52')
('t1__df87de', 'fqyp')
('t1__df87de', 'au2dwy')
('t1__df87de', '9000t5c4ec')
('t1__df87de', 'y9uxj4')
*/