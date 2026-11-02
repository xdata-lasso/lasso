-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__9814ce', 'molecule_i_1', 't2__8599f7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 't2__8599f7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__154286', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't2__8599f7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'nw6klf');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'bbp02eutliqa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'ytoo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__ba8b6e', 'molecule_i_1', '72k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', '4ji7zwa');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR000_2_3', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__ef73e8', 'molecule_i_1', 'rqrofqyp5s');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9814ce', 't1__9814ce', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9814ce', 'atom_id_2', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__154286', 't1__154286', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_2', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't1__9814ce', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_2', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9814ce', 'atom_id_7', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9814ce', 'O', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9814ce', 'G', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9814ce', 'atom_id_8', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9814ce', 'atom_id_9', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9814ce', 'atom_id_10', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9814ce', 'atom_id_11', 't1__ef73e8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9814ce', 'atom_id_12', 't1__ef73e8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9814ce', 'atom_id_14', 'TR000_2_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR000_2_3';

/*
Gold Result:
('t2__8599f7',)
('t2__8599f7',)
('a2ypuzhsrwbb',)
('hvdltt',)
('hvdltt',)
('mdpos',)
('t2__8599f7',)
('t2__8599f7',)
('t2__8599f7',)
('t2__8599f7',)
('t2__8599f7',)
('t2__8599f7',)
('t2__8599f7',)
*/

-- Prediction Query
SELECT DISTINCT T2.element, T3.element FROM connected AS T1 JOIN atom AS T2 ON T1.atom_id = T2.atom_id JOIN atom AS T3 ON T1.atom_id2 = T3.atom_id WHERE T1.bond_id = 'TR000_2_3';

/*
Prediction Result:
('t2__8599f7', 't2__8599f7')
('a2ypuzhsrwbb', 'a2ypuzhsrwbb')
('hvdltt', 't2__8599f7')
('mdpos', 't2__8599f7')
('t2__8599f7', 'nw6klf')
('t2__8599f7', 'mdpos')
('t2__8599f7', 'hvdltt')
('t2__8599f7', '00t5c4ecigc')
('t2__8599f7', 'um5')
('t2__8599f7', 'u')
('t2__8599f7', '4ji7zwa')
*/