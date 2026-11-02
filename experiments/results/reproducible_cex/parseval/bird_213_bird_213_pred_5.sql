-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR004_20', 'molecule_i_1', '9n8c4pgu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR004_8', 'molecule_i_1', '4h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'dpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA?', 'molecule_i_1', '5u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__d86cd0', 'molecule_i_1', '6klfa9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__f2521d', 'molecule_i_1', '00t5c4ecigc');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__a9d3f8', 'molecule_i_1', 't1__15f0af');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__4f415d', 'molecule_i_1', 't1__15f0af');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 't1__15f0af');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 'puzhsrw');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', 'luhvdltti');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__56e8df', 'molecule_i_1', 't1__15f0af');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'um5');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('P', 'molecule_i_1', 'u');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR004_20', 'TR004_8', 't1__a9d3f8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR004_20', 'G', 't1__a9d3f8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('AA?', 'TR004_8', 't1__a9d3f8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__d86cd0', 't2__f2521d', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR004_8', 'AA?', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'TR004_20', 'P');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = 'TR004_8' AND T2.atom_id2 = 'TR004_20' OR T2.atom_id2 = 'TR004_8' AND T2.atom_id = 'TR004_20';

/*
Gold Result:
('t1__15f0af',)
*/

-- Prediction Query
SELECT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = 'TR004_8' AND T2.atom_id2 = 'TR004_20';

/*
Prediction Result:
*/