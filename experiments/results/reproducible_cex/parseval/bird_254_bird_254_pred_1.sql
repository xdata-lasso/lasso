-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_f1a257', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__232852', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('$', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'molecule_i_1', '6nium52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('"', 'molecule_i_1', 'rqro');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'oo3o9hl72kl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', '4ji7zwa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__02f7f4', 'molecule_i_1', '2dwyrq13pyu7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('R', 'molecule_i_1', 'x58pz');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('S', 'molecule_i_1', '8jegd21vy9ux');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('%', 'molecule_i_1', 'x5hncprjtu0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('d', 'molecule_i_1', 'gq8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'dqv0gcb98ozk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', '6ah');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'xb72fxa7r');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '9n8');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__191d9e', 'molecule_i_1', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('a', 'molecule_i_1', 'sr');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 'molecule_i_1', 'nw6klf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t', 'molecule_i_1', 'a9000t5c4eci');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('e', 'molecule_i_1', 's5bbp02e');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', '5qi2');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('!', 'molecule_i_1', 'lph2gn');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 'molecule_i_1', 'q');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'dr');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f1a257', 'con_f1a257', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__232852', 't1__232852', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('$', 'con_f1a257', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('a', 't1__232852', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f1a257', 't1__232852', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__232852', 'con_f1a257', '?');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('!', '$', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('"', '"', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f1a257', '!', '?');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__232852', 'a', 'e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f1a257', 'atom_id_7', 't');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__232852', 'atom_id_8', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__02f7f4', 't1__02f7f4', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f1a257', 'atom_id_10', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__232852', 'atom_id_7', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__02f7f4', 'atom_id_10', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('R', 'atom_id_7', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('S', 'atom_id_10', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f1a257', 'atom_id_8', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__232852', '"', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__02f7f4', 'con_f1a257', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('%', 'con_f1a257', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('d', 'S', 't');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f1a257', 'atom_id_15', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__232852', 'atom_id_16', 'B');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__02f7f4', '"', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f1a257', 'atom_id_17', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__232852', 'd', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f1a257', 'S', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__232852', 'atom_id_18', 't1__191d9e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_7', '%', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_7', 'atom_id_17', 't');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(37.5,)
*/

-- Prediction Query
SELECT 100.0 * CAST(COUNT(connected.bond_id) AS REAL) / CAST((SELECT COUNT(*) FROM connected) AS REAL) AS percentage FROM connected JOIN atom AS a1 ON connected.atom_id = a1.atom_id JOIN atom AS a2 ON connected.atom_id2 = a2.atom_id GROUP BY a1.element, a2.element ORDER BY COUNT(*) DESC, percentage NULLS LAST LIMIT 1;

/*
Prediction Result:
(3.125,)
*/