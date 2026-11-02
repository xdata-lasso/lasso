-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_a85e8d', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__89dc4e', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('4', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'molecule_i_1', '6nium52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'a11ry');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__49eddb', 'molecule_i_1', 'oo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', '7zwau2dwyr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', '0b4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('q', 'molecule_i_1', 'i2rkf');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'pz0f8jegd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'y9uxj4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'cx5hn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '0gcb98');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'lyr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', '6vck6ah0f8js');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '9n8');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__6e3bfb', 'molecule_i_1', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('a', 'molecule_i_1', 'sr');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'nw6klf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'molecule_i_1', 'rofqyp5s5b');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'd');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('!', 'molecule_i_1', 'gq8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', 'lq7xb7');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_a85e8d', 'con_a85e8d', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__89dc4e', 't1__89dc4e', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('4', 'con_a85e8d', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('D', 't1__89dc4e', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_a85e8d', 't1__89dc4e', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__89dc4e', 'con_a85e8d', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('!', '4', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('D', 'D', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_a85e8d', '!', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__89dc4e', '4', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_a85e8d', '4', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__89dc4e', 'atom_id_6', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__49eddb', 'con_a85e8d', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_a85e8d', 'D', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__89dc4e', 'atom_id_8', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__49eddb', '!', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__49eddb', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('q', 'A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_a85e8d', 'atom_id_11', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__89dc4e', 'atom_id_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__49eddb', 't1__89dc4e', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'con_a85e8d', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '!', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_a85e8d', 'atom_id_14', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__89dc4e', 'A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__49eddb', 'A', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_a85e8d', 'atom_id_8', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__89dc4e', 'atom_id_15', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_a85e8d', 'atom_id_16', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__89dc4e', 'atom_id_17', 't1__6e3bfb');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_8', 'atom_id_15', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_6', '4', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(37.5,)
*/

-- Prediction Query
WITH ElementCombinations AS (SELECT a.element AS element1, a2.element AS element2, COUNT(b.bond_id) AS bond_count FROM bond AS b JOIN connected AS c ON b.bond_id = c.bond_id JOIN atom AS a ON c.atom_id = a.atom_id JOIN atom AS a2 ON c.atom_id2 = a2.atom_id GROUP BY a.element, a2.element), MostCommonCombination AS (SELECT element1, element2, bond_count FROM ElementCombinations WHERE bond_count = (SELECT MAX(bond_count) FROM ElementCombinations)), TotalBonds AS (SELECT COUNT(*) AS total_bonds FROM bond) SELECT (mcc.bond_count * 100.0 / tb.total_bonds) AS percentage FROM MostCommonCombination AS mcc CROSS JOIN TotalBonds AS tb;

/*
Prediction Result:
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
(14.285714285714286,)
*/