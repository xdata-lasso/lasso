-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__740092', 'molecule_i_1', 't1__b29c07');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__1965b9', 'molecule_i_1', 't1__b29c07');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't1__b29c07');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 't1__b29c07');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'sr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 't1__b29c07');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'nprmdposii');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 't1__b29c07');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', '6klfa9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__302c95', 'molecule_i_1', 't1__b29c07');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 't1__b29c07');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 't1__b29c07');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 't1__b29c07');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'bbp02eut');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'ytoo3o9');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR004_8_9', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__89fdfe', 'molecule_i_1', '52zb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__2f34f1', 'molecule_i_1', 'nrqrofqy');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__740092', 't1__740092', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__740092', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_8', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_9', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_11', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_7', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__302c95', 'atom_id_4', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__302c95', 'atom_id_8', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__302c95', 'atom_id_10', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__302c95', 't1__1965b9', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__302c95', 't2__302c95', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__302c95', 'atom_id_16', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__740092', 'atom_id_4', 't2__89fdfe');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__740092', 'atom_id_11', 't2__2f34f1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__302c95', 'atom_id_17', 't2__89fdfe');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__302c95', 'O', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__740092', 'atom_id_14', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__740092', 'atom_id_18', 'TR004_8_9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR004_8_9';

/*
Gold Result:
('t1__b29c07',)
('sr',)
*/

-- Prediction Query
SELECT element FROM atom WHERE atom_id IN (SELECT atom_id FROM connected WHERE bond_id = 'TR004_8_9') UNION SELECT element FROM atom WHERE atom_id IN (SELECT atom_id2 FROM connected WHERE bond_id = 'TR004_8_9');

/*
Prediction Result:
('6klfa9',)
('a2y',)
('e',)
('luhvdltti',)
('nprmdposii',)
('sr',)
('t1__b29c07',)
('ytoo3o9',)
*/