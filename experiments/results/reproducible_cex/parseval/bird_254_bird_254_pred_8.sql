-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_8186a0', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__0ecc33', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('E', 'molecule_i_1', '6nium52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('f', 'molecule_i_1', 'rqro');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__f79a90', 'molecule_i_1', 'tliqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'ex1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('#', 'molecule_i_1', 'yrq13p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', '9rljsl0b4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'rkf9vqx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('`', 'molecule_i_1', 'wnqcx');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'rjtu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'qv0gcb98ozk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'i');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '9n8');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__8c4e82', 'molecule_i_1', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('R', 'molecule_i_1', 'sr');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'molecule_i_1', 'nw6klf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('a', 'molecule_i_1', 'a9000t5c4eci');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', '7zw');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('"', 'molecule_i_1', 'z0f8jegd21vy');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('0', 'molecule_i_1', '79fjgq8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', '6vck6ah0f8js');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_8186a0', 'con_8186a0', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0ecc33', 't1__0ecc33', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('!', 'con_8186a0', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+', 't1__0ecc33', 'R');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_8186a0', 't1__0ecc33', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0ecc33', 'con_8186a0', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('E', '!', 'R');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('f', 'f', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_8186a0', 'E', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0ecc33', '+', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_8186a0', 'f', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0ecc33', 'E', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__f79a90', '+', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_8186a0', 'atom_id_8', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0ecc33', 'atom_id_8', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__f79a90', '!', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('#', 't1__f79a90', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't1__f79a90', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_8186a0', '+', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0ecc33', 'atom_id_11', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__f79a90', '#', '"');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('!', 't1__0ecc33', 'R');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('`', 'atom_id_11', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_8186a0', 'atom_id_11', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0ecc33', 'atom_id_13', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__f79a90', 't1__f79a90', '0');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_8186a0', 'atom_id_14', '"');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0ecc33', 'atom_id_15', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_8186a0', '`', 'R');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__0ecc33', 'C', 't1__8c4e82');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_8', 'f', '"');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_8', '!', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(37.5,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN c.bond_id IN (SELECT bond_id FROM connected JOIN atom AS a1 ON connected.atom_id = a1.atom_id JOIN atom AS a2 ON connected.atom_id2 = a2.atom_id WHERE (a1.element, a2.element) = (SELECT a1.element, a2.element FROM connected JOIN atom AS a1 ON connected.atom_id = a1.atom_id JOIN atom AS a2 ON connected.atom_id2 = a2.atom_id GROUP BY a1.element, a2.element ORDER BY COUNT(*) DESC, a1.element NULLS LAST, a2.element NULLS LAST LIMIT 1)) THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(c.bond_id) AS percentage FROM connected AS c;

/*
Prediction Result:
(12.5,)
*/