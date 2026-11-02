-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_6d6256', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__f4c7f9', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('4', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'bbp02eutliqa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__2ca3af', 'molecule_i_1', 'au2dwy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'b4yp5qi');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'd21vy9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('1', 'molecule_i_1', 'v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('y', 'molecule_i_1', 'h2gndqwnqcx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('3', 'molecule_i_1', 'f3dqv0gc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Z', 'molecule_i_1', 'k3zbily');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', '7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'fdrz16n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'ai5');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '9n8');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__f3b8e6', 'molecule_i_1', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 'molecule_i_1', 'sr');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 'a9');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=', 'molecule_i_1', '76nium52');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('`', 'molecule_i_1', 'zbuo4nrqrof');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', 'yytoo');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'x58pz');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'cprj');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'molecule_i_1', 'u0dz7');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('D', 'molecule_i_1', 'n6vck6ah0f');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('p', 'molecule_i_1', 'h5ogrgjd8yz');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_6d6256', 'con_6d6256', 't1__f3b8e6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__f4c7f9', 't1__f4c7f9', 't1__f3b8e6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_6d6256', 'atom_id_3', 't1__f3b8e6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('4', 't1__f4c7f9', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('D', 'D', '=');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_6d6256', '4', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '4', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', '4', '?');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_6d6256', 't1__f4c7f9', '`');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__f4c7f9', 'D', 't1__f3b8e6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__2ca3af', 'D', 't1__f3b8e6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_6d6256', 'atom_id_9', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__f4c7f9', 't1__2ca3af', 't1__f3b8e6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__2ca3af', 'atom_id_10', 't1__f3b8e6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_6d6256', 'atom_id_11', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('1', 'atom_id_3', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('y', 'atom_id_11', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_6d6256', 'D', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('3', 'con_6d6256', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Z', 'D', 'D');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_6d6256', 'A', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__f4c7f9', 'atom_id_16', 't1__f3b8e6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_6d6256', 'atom_id_17', 'D');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__f4c7f9', 'atom_id_18', 't1__f3b8e6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_3', 'atom_id_10', 'p');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_3', '3', 't1__f3b8e6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(38.46153846153846,)
*/

-- Prediction Query
SELECT CAST((SELECT COUNT(*) FROM connected AS c INNER JOIN atom AS a ON c.atom_id = a.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE a.element || '-' || a2.element = (SELECT a.element || '-' || a2.element FROM connected AS c INNER JOIN atom AS a ON c.atom_id = a.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id GROUP BY a.element, a2.element ORDER BY COUNT(*) DESC, a.element || '-' || a2.element NULLS LAST LIMIT 1)) AS REAL) * 100 / (SELECT COUNT(*) FROM connected);

/*
Prediction Result:
(3.8461538461538463,)
*/