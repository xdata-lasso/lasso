-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'TR024', 't1__2e6777');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'TR024', 't1__2e6777');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'TR024', 't1__2e6777');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'TR024', 't1__2e6777');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'TR024', 't1__2e6777');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'TR024', 't1__2e6777');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'TR024', 't1__2e6777');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'TR024', 't1__2e6777');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't1__6979f2', 't1__2e6777');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'TR024', 't1__2e6777');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'TR024', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR024', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('!', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__6979f2', 'gu7v');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 'TR024', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 'TR024', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'TR024', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', '!', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'TR024', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'TR024', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 'TR024', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__6979f2', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'TR024', 't2__59fdf5');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'TR024', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR024' AND T2.bond_type = '=';

/*
Gold Result:
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
('t1__2e6777',)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT "atom"."element" FROM "atom" INNER JOIN "bond" ON "atom"."molecule_id" = "bond"."molecule_id" WHERE "bond"."bond_type" = '=' AND "bond"."molecule_id" = 'TR024';

/*
Prediction Result:
('t1__2e6777',)
(None,)
*/