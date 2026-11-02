-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_f8bfb2', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__33664a', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('0', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('`', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('(', 'molecule_i_1', 'bbp02eutliqa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('h', 'molecule_i_1', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__d6b493', 'molecule_i_1', 'au2dwy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'b4yp5qi');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'd21vy9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'molecule_i_1', 'v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('[', 'molecule_i_1', 'h2gndqwnqcx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('U', 'molecule_i_1', 'f3dqv0gc');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '9n8');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__a93d4f', 'molecule_i_1', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 'sr');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', 'a9');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 'molecule_i_1', '76nium52');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b', 'molecule_i_1', 'zbuo4nrqrof');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('P', 'molecule_i_1', 'yytoo');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('K', 'molecule_i_1', 'x58pz');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', 'cprj');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'molecule_i_1', 'u0dz7');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('0', 'molecule_i_1', 'k3zbily');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'jswwlq7xb');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f8bfb2', 'con_f8bfb2', 't1__a93d4f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__33664a', 't1__33664a', 't1__a93d4f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f8bfb2', 'atom_id_3', 't1__a93d4f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('0', 't1__33664a', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('`', '`', '?');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f8bfb2', '0', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('(', '0', 'P');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('h', '0', '?');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f8bfb2', 't1__33664a', 'b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__33664a', '`', 't1__a93d4f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__d6b493', '`', 't1__a93d4f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f8bfb2', 'atom_id_9', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__33664a', 't1__d6b493', 't1__a93d4f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__d6b493', 'atom_id_10', 't1__a93d4f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f8bfb2', 'atom_id_11', 'K');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('!', 'atom_id_3', 'K');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('[', 'atom_id_11', 'C');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f8bfb2', '`', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('U', 'con_f8bfb2', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('h', 'atom_id_9', '0');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f8bfb2', '!', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__33664a', '(', 't1__a93d4f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_f8bfb2', 'atom_id_10', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__33664a', 'h', 't1__a93d4f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_3', 'atom_id_10', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_9', 'atom_id_11', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(34.61538461538461,)
*/

-- Prediction Query
SELECT CAST(COUNT("b"."bond_id") AS REAL) * 100 / (SELECT COUNT("b2"."bond_id") FROM "bond" AS "b2") AS "percentage" FROM "bond" AS "b" INNER JOIN "connected" AS "c1" ON "b"."bond_id" = "c1"."bond_id" INNER JOIN "atom" AS "a1" ON "c1"."atom_id" = "a1"."atom_id" INNER JOIN "connected" AS "c2" ON "b"."bond_id" = "c2"."bond_id" INNER JOIN "atom" AS "a2" ON "c2"."atom_id2" = "a2"."atom_id" GROUP BY "a1"."element", "a2"."element" ORDER BY COUNT("b"."bond_id") DESC, percentage NULLS LAST LIMIT 1;

/*
Prediction Result:
(90.9090909090909,)
*/