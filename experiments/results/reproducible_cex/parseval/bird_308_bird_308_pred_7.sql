-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__b4c5f2', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'molecule_i_1', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'p6luhvdlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'siie5unw6k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'rqrofqyp5s');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'tliqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'ytoo3o9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__14f80e', 'molecule_i_1', 'lex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', '2dwyrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', '78d99r');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__d842e2', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__199f5c', 'molecule_i_1', 'rmdp');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 't1__b4c5f2', 't1__d842e2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 'C', 't1__d842e2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', 't1__d842e2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'C', 't1__d842e2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '?', 't1__d842e2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'atom_id_7', 't1__d842e2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'atom_id_8', 't1__199f5c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'A', 't1__d842e2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'atom_id_9', 't1__199f5c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'atom_id_10', 't1__d842e2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'atom_id_11', 't1__199f5c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'atom_id_12', 't1__d842e2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'atom_id_13', 't1__199f5c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'atom_id_14', 't1__199f5c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'atom_id_15', 't1__199f5c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'G', 't1__d842e2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'atom_id_17', 't1__199f5c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', 'atom_id_18', 't1__d842e2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b4c5f2', '?', 't1__d842e2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'cl';

/*
Gold Result:
(18,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "connected"."bond_id") FROM "connected" INNER JOIN "atom" ON "connected"."atom_id" = "atom"."atom_id" OR "connected"."atom_id2" = "atom"."atom_id" WHERE "atom"."element" = 'cl';

/*
Prediction Result:
(2,)
*/