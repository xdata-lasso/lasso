-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__0778e1', 'molecule_i_1', 't1__b87a6d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__a9041c', 'molecule_i_1', 't1__b87a6d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 't1__b87a6d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't1__b87a6d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'sr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'molecule_i_1', 't1__b87a6d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'dlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__2099e1', 'molecule_i_1', 't1__b87a6d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 't1__b87a6d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 't1__b87a6d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'ie5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 't1__b87a6d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', '6nium52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'rqrofqyp5s');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', '02eutliqa11r');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR004_8_9', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__474262', 'molecule_i_1', '9000t5c4ec');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__229b99', 'molecule_i_1', 'e');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0778e1', 't1__0778e1', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0778e1', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'Q', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'Q', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't1__a9041c', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_8', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't1__0778e1', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2099e1', 'A', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2099e1', 'O', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2099e1', 'atom_id_12', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2099e1', 'Q', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2099e1', 't2__2099e1', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2099e1', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0778e1', 'atom_id_12', 't2__474262');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0778e1', 'atom_id_14', 't2__229b99');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2099e1', 'atom_id_11', 't2__474262');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__2099e1', 'atom_id_15', 't2__474262');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0778e1', 'atom_id_16', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0778e1', 'atom_id_13', 'TR004_8_9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR004_8_9';

/*
Gold Result:
('t1__b87a6d',)
('sr',)
*/

-- Prediction Query
SELECT DISTINCT atom1.element FROM connected AS conn INNER JOIN atom AS atom1 ON conn.atom_id = atom1.atom_id INNER JOIN atom AS atom2 ON conn.atom_id2 = atom2.atom_id WHERE conn.bond_id = 'TR004_8_9' UNION SELECT DISTINCT atom2.element FROM connected AS conn INNER JOIN atom AS atom1 ON conn.atom_id = atom1.atom_id INNER JOIN atom AS atom2 ON conn.atom_id2 = atom2.atom_id WHERE conn.bond_id = 'TR004_8_9';

/*
Prediction Result:
('02eutliqa11r',)
('a2y',)
('dlttil',)
('ie5',)
('sr',)
('t1__b87a6d',)
*/