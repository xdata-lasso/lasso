-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__40df95', 'molecule_i_1', 't1__e6f5a5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__1d4ea8', 'molecule_i_1', 't1__e6f5a5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 't1__e6f5a5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't1__e6f5a5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 't1__e6f5a5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__dbf8c6', 'molecule_i_1', 't1__e6f5a5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 't1__e6f5a5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 't1__e6f5a5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'siie5unw6k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 't1__e6f5a5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '6nium52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'rqrofqyp5s');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '02eutliqa11r');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR004_8_9', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__ff4600', 'molecule_i_1', '5c4ec');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__955076', 'molecule_i_1', 'e');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__40df95', 't1__40df95', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__40df95', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__40df95', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'G', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_7', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__1d4ea8', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dbf8c6', 'O', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dbf8c6', 'A', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dbf8c6', 'atom_id_11', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dbf8c6', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dbf8c6', 'atom_id_10', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dbf8c6', 'atom_id_8', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__40df95', 'atom_id_10', 't2__ff4600');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__40df95', 'atom_id_13', 't2__955076');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__dbf8c6', 'atom_id_14', 't2__ff4600');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__40df95', 'atom_id_15', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__40df95', 'atom_id_7', 'TR004_8_9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR004_8_9';

/*
Gold Result:
('t1__e6f5a5',)
*/

-- Prediction Query
SELECT DISTINCT T2."element" FROM "connected" AS T1 INNER JOIN "atom" AS T2 ON T1."atom_id" = T2."atom_id" OR T1."atom_id2" = T2."atom_id" WHERE T1."bond_id" = 'TR004_8_9';

/*
Prediction Result:
('t1__e6f5a5',)
('a2y',)
('luhvdltti',)
('siie5unw6k',)
('02eutliqa11r',)
*/