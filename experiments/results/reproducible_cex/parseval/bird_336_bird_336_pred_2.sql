-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__135d8f', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__55453b', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', 't1__73e41a');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__135d8f', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 'C', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 't2__55453b', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't2__55453b', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't2__55453b', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 't1__135d8f', 't2__55c8a9');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__135d8f', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 't1__135d8f', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', '@', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 'B', 't2__0ab259');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '#' AND T1.label = '-';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(m.molecule_id) FROM molecule AS m INNER JOIN bond AS b ON m.molecule_id = b.molecule_id WHERE m.label = '-' AND b.bond_type = '#';

/*
Prediction Result:
(9,)
*/