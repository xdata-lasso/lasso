-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__4d6412', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__e1fc82', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__3543cb', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__8c0603', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'wbbp6luhvdlt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '5c4ec');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__e1ccc2', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'p5s5bbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'liqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', '4ji7zwa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', '78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'l0b4y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', 'rkf9vqx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'z0f8jegd21vy');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__996c3e', 'molecule_i_1', 'u7');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', 'atom_id_1', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', 't3__3543cb', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 't1__4d6412', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__8c0603', 'atom_id_1', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't3__3543cb', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 't1__e1fc82', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', 'atom_id_9', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't3__3543cb', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', 'O', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_9', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 't3__3543cb', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', 't1__4d6412', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'I', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_12', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'atom_id_13', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e1ccc2', 'atom_id_13', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e1ccc2', 't3__3543cb', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'A', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', 'atom_id_15', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'atom_id_1', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'O', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', '_', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 't3__8c0603', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'I', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e1ccc2', '_', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e1ccc2', 't1__e1fc82', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'atom_id_16', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', 'atom_id_17', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 't2__e1ccc2', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'atom_id_9', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e1ccc2', 'I', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e1ccc2', 'O', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'atom_id_18', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', 'A', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'atom_id_19', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', 't1__e1fc82', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'atom_id_12', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e1ccc2', 'atom_id_9', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', 'atom_id_20', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'atom_id_21', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__4d6412', 'atom_id_22', 't2__996c3e');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__3543cb', 'atom_id_23', 't2__996c3e');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
('t2__996c3e',)
*/

-- Prediction Query
SELECT DISTINCT b."bond_id" FROM "bond" AS b INNER JOIN "connected" AS c ON b."bond_id" = c."bond_id" INNER JOIN "atom" AS a1 ON c."atom_id" = a1."atom_id" INNER JOIN "atom" AS a2 ON c."atom_id2" = a2."atom_id" WHERE (a1."element" = 'p' OR a2."element" = 'p') AND (a1."element" = 'n' OR a2."element" = 'n');

/*
Prediction Result:
('t2__996c3e',)
*/