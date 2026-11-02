-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__44fef2', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'fa9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', '5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'm52zbu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__7494bb', 'molecule_i_1', 'rqrofqyp5s');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '2eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'oo3o9hl72kl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'ji7zwau2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'yrq13pyu78d9');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__7ba191', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__f82497', 'molecule_i_1', 'dlttil');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 't1__44fef2', 't1__7ba191');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 'C', 't1__7ba191');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', 't1__7ba191');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'C', 't1__7ba191');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_6', 't1__7ba191');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'C', 't1__7ba191');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'atom_id_6', 't1__f82497');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'G', 't1__7ba191');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'A', 't1__f82497');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'atom_id_7', 't1__7ba191');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'atom_id_8', 't1__f82497');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'atom_id_9', 't1__7ba191');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'atom_id_10', 't1__f82497');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'atom_id_11', 't1__7ba191');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'O', 't1__f82497');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'atom_id_13', 't1__7ba191');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'atom_id_14', 't1__f82497');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'atom_id_15', 't1__f82497');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__44fef2', 'atom_id_16', 't1__7ba191');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'cl';

/*
Gold Result:
(18,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.bond_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'cl';

/*
Prediction Result:
(2,)
*/