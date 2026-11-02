-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_538ca6', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__43c64c', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('"', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('1', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'molecule_i_1', 'bbp02eutliqa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'molecule_i_1', 'yytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', '3pyu78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__230967', 'molecule_i_1', 'l0b4y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'j4hwbdvlph');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'dqwn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('#', 'molecule_i_1', '3d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('%', 'molecule_i_1', '0gcb98');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', '6vck6ah0f8js');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '7');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '9n8');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__216033', 'molecule_i_1', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('/', 'molecule_i_1', 'sr');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('+', 'molecule_i_1', 'a9');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', '76nium52');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('K', 'molecule_i_1', 'zbuo4nrqrof');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'hl72klex1');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('#', 'molecule_i_1', 'f8jegd2');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('"', 'molecule_i_1', 'x5hncprjtu0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('%', 'molecule_i_1', '3zb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 'molecule_i_1', 'xa');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_538ca6', 'con_538ca6', 't1__216033');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__43c64c', 't1__43c64c', 't1__216033');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_538ca6', 'atom_id_3', 't1__216033');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('"', 't1__43c64c', '+');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('1', '1', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_538ca6', '"', '+');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('!', '"', '+');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('D', '"', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_538ca6', 'atom_id_8', '+');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__43c64c', 'atom_id_3', 't1__216033');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__230967', '"', 't1__216033');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_538ca6', 't1__230967', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__43c64c', '"', 't1__216033');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__230967', 'D', 't1__216033');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_538ca6', 'atom_id_10', '+');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('!', 'atom_id_8', '#');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '1', '"');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_538ca6', '1', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('#', 'A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('%', '"', '%');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_538ca6', 'atom_id_14', '+');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__43c64c', '!', 't1__216033');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_538ca6', 'atom_id_15', '%');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__43c64c', 'A', 't1__216033');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_3', 'atom_id_10', '%');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_3', '%', 'K');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(34.61538461538461,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN element1 <> element2 THEN bond_id ELSE NULL END) AS REAL) * 100 / COUNT(bond_id) FROM (SELECT T2.bond_id, T1.element AS element1, T3.element AS element2 FROM atom AS T1 JOIN connected AS T4 ON T1.atom_id = T4.atom_id JOIN atom AS T3 ON T3.atom_id = T4.atom_id2 JOIN bond AS T2 ON T2.bond_id = T4.bond_id) WHERE element1 <> element2;

/*
Prediction Result:
(100.0,)
*/