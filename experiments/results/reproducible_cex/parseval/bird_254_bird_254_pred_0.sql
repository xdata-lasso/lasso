-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_334d94', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__7f61f4', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('$', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('`', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('"', 'molecule_i_1', 'bbp02eutliqa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a', 'molecule_i_1', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', '3pyu78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__6c3841', 'molecule_i_1', 'l0b4y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'j4hwbdvlph');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('M', 'molecule_i_1', 'nd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Z', 'molecule_i_1', 'qcx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'f3dqv0gc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'k3zbily');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'h0f8jswwlq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'dh5ogrgj');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '9n8');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__74ac0a', 'molecule_i_1', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('{', 'molecule_i_1', 'sr');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('7', 'molecule_i_1', 'a9');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', '76nium52');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'zbuo4nrqrof');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 'yytoo');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 'molecule_i_1', 'ex1');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('!', 'molecule_i_1', 'cprj');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('h', 'molecule_i_1', 'u0dz7');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', '7ryfdrz16n');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_334d94', 'con_334d94', 't1__74ac0a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__7f61f4', 't1__7f61f4', 't1__74ac0a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_334d94', 'atom_id_3', 't1__74ac0a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('$', 't1__7f61f4', '7');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('`', '`', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_334d94', '$', '7');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('"', '$', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('a', '$', '?');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_334d94', 'atom_id_8', '7');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__7f61f4', 'atom_id_3', 't1__74ac0a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6c3841', '$', 't1__74ac0a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_334d94', 't1__6c3841', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__7f61f4', '$', 't1__74ac0a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6c3841', 'a', 't1__74ac0a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_334d94', 'atom_id_10', '7');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('M', '`', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Z', 'M', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_334d94', '`', 'h');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'con_334d94', 'h');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', '`', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_334d94', 'atom_id_15', '7');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__7f61f4', 'C', 't1__74ac0a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_334d94', 'C', '{');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__7f61f4', '"', 't1__74ac0a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_8', 'atom_id_3', '7');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_8', 'atom_id_16', 't1__74ac0a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(38.46153846153846,)
*/

-- Prediction Query
SELECT CAST(COUNT(T1.bond_id) AS REAL) * 100 / (SELECT COUNT(T2.atom_id) FROM (SELECT atom_id, COUNT(atom_id) AS atom_count FROM connected GROUP BY atom_id ORDER BY atom_count DESC, atom_id NULLS LAST LIMIT 1) AS T2) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id;

/*
Prediction Result:
(2600.0,)
*/