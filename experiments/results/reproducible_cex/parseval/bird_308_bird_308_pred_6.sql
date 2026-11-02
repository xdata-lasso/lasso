-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__6b2dc2', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'p6luhvdlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'siie5unw6k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'rqrofqyp5s');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'tliqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'ytoo3o9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__7fed7a', 'molecule_i_1', 'lex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', '2dwyrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', '78d99r');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__9434ac', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__e2248d', 'molecule_i_1', 'rmdp');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 't1__6b2dc2', 't1__9434ac');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 'C', 't1__9434ac');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'Q', 't1__9434ac');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'C', 't1__9434ac');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '_', 't1__9434ac');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'atom_id_7', 't1__9434ac');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'atom_id_8', 't1__e2248d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'A', 't1__9434ac');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'atom_id_9', 't1__e2248d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'atom_id_10', 't1__9434ac');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'atom_id_11', 't1__e2248d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'atom_id_12', 't1__9434ac');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'atom_id_13', 't1__e2248d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'atom_id_14', 't1__e2248d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'atom_id_15', 't1__e2248d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'G', 't1__9434ac');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'atom_id_17', 't1__e2248d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', 'atom_id_18', 't1__9434ac');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6b2dc2', '_', 't1__9434ac');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'cl';

/*
Gold Result:
(18,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.bond_id) FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id WHERE a.element = 'cl' OR a.element = 'cl';

/*
Prediction Result:
(2,)
*/