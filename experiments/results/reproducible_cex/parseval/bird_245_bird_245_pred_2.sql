-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__30da7e', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'sr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'p6luhvdlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__198f83', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'a9000t5c4eci');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', '76nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'uo4nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', '02eu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '1ryytoo');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('1', 'molecule_i_1', '8c4pgu7vfe');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__30da7e', 't1__30da7e', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'A', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't1__30da7e', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'C', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__198f83', 't1__30da7e', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__198f83', 'Q', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__198f83', 'C', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__198f83', 'A', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__198f83', 't2__198f83', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__198f83', 'atom_id_8', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__198f83', 'atom_id_9', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__198f83', 'atom_id_10', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__30da7e', 'atom_id_8', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__30da7e', 'atom_id_11', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__198f83', 'O', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__198f83', 'atom_id_12', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__30da7e', 'Q', '1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__30da7e', 'A', '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(DISTINCT T1.atom_id) AS average_bonds FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Prediction Result:
(7.5,)
*/