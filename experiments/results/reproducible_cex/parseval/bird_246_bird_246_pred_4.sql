-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAAAA45A', 'molecule_i_1', '9n8c4pgu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('CAAAAA45A', 'molecule_i_1', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA!AAA45A', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAAAAA45A', 'molecule_i_1', 'nprmdposii');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_AAAAA45A', 'molecule_i_1', 'w6kl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAAAAA45A', 'molecule_i_1', '52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAAAAAAAA', 'molecule_i_1', 'nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__b13f38', 'molecule_i_1', 'bbp02eut');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__58c39c', 'molecule_i_1', 't1__dd3a00');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'molecule_i_1', 't1__dd3a00');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'b');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 't1__dd3a00');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__d15130', 'molecule_i_1', 't1__dd3a00');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('AAAAAA45A', 'AAAAAA45A', 't1__58c39c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('CAAAAA45A', 'CAAAAA45A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA!AAA45A', 'AAAAAA45A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', 'AAAAAA45A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_AAAAA45A', 'AAAAAA45A', 't2__d15130');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', 'atom_id_6', 't2__d15130');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', 'OAAAAA45A', 't2__d15130');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAA45A', '_AAAAA45A', 't2__d15130');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_AAAAA45A', 'CAAAAA45A', 't2__d15130');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GAAAAA45A', 'atom_id_6', 't2__d15130');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAAAAAAAA', 'OAAAAA45A', 't1__58c39c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__b13f38', 'OA!AAA45A', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GAAAAA45A', 'AAAAAA45A', 't1__58c39c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_type, T1.bond_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE SUBSTRING(T2.atom_id, 7, 2) = '45';

/*
Gold Result:
('t1__dd3a00', 't1__58c39c')
('b', 'A')
('b', 'A')
('b', 'A')
('t1__dd3a00', 't2__d15130')
('t1__dd3a00', 't2__d15130')
('t1__dd3a00', 't2__d15130')
('t1__dd3a00', 't2__d15130')
('t1__dd3a00', 't2__d15130')
('t1__dd3a00', 't2__d15130')
('t1__dd3a00', 't1__58c39c')
*/

-- Prediction Query
SELECT T1.bond_type, CAST(SUBSTRING(T2.atom_id, 7, 2) AS INTEGER) AS bond_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE CAST(SUBSTRING(T2.atom_id, 7, 2) AS INTEGER) = 45;

/*
Prediction Result:
('t1__dd3a00', 45)
('b', 45)
('b', 45)
('b', 45)
('t1__dd3a00', 45)
('t1__dd3a00', 45)
('t1__dd3a00', 45)
('t1__dd3a00', 45)
('t1__dd3a00', 45)
('t1__dd3a00', 45)
('t1__dd3a00', 45)
*/