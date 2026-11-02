-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__a30ab7', 'molecule_i_1', 't1__2d542b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__f1a85f', 'molecule_i_1', 't1__2d542b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'ypuzhsrw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 'p6luhvdlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't1__2d542b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'a9000t5c4eci');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'molecule_i_1', '76nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'rqro');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', '5s5b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__0052e8', 'molecule_i_1', 't1__2d542b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'ryytoo3');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '72k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', '4ji7zwa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'yrq13p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', '8d99rljsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'z0f8jegd21vy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'j4hwbd');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_10_11', 'molecule_i_1', '9n8c4pgu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'w6kl');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__d69574', 'molecule_i_1', 'h2gn');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t3__d2f84e', 'molecule_i_1', 'x5hncprjtu0');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 't1__a30ab7', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'atom_id_3', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'atom_id_4', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't1__f1a85f', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'atom_id_7', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('I', 'atom_id_7', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'atom_id_9', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't1__a30ab7', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'I', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0052e8', 'A', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0052e8', 'atom_id_3', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'atom_id_12', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'atom_id_13', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0052e8', 'atom_id_13', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0052e8', 'atom_id_14', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'atom_id_15', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'atom_id_16', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0052e8', 'atom_id_16', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0052e8', 'atom_id_17', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'atom_id_18', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'atom_id_19', 'TR001_10_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 't1__f1a85f', 't2__d69574');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0052e8', 'atom_id_9', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__0052e8', 'atom_id_7', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a30ab7', 'atom_id_17', 'TR001_10_11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_id = 'TR001_10_11';

/*
Gold Result:
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
('mdpos',)
('76nium52',)
('5s5b',)
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
('t1__2d542b',)
*/

-- Prediction Query
SELECT DISTINCT a.element FROM atom AS a JOIN connected AS c ON a.atom_id IN (c.atom_id, c.atom_id2) WHERE c.bond_id = 'TR001_10_11';

/*
Prediction Result:
('t1__2d542b',)
('ypuzhsrw',)
('p6luhvdlttil',)
('mdpos',)
('76nium52',)
('a9000t5c4eci',)
('5s5b',)
('ryytoo3',)
('72k',)
('4ji7zwa',)
('yrq13p',)
('8d99rljsl',)
('qi2rkf9v',)
('z0f8jegd21vy',)
('j4hwbd',)
*/