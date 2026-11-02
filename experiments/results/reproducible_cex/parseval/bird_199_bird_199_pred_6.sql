-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__9af9a4', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'A', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'O', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'G', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'O', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't1__9af9a4', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__9af9a4', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__9af9a4', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__9af9a4', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__9af9a4', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 't1__9af9a4', 't1__e19998');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__9af9a4', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__9af9a4', 'na');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', '_', 'na');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__9af9a4', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__2b8fc5', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'na' AND T2.label = '-';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'na' AND T2.label = '-';

/*
Prediction Result:
(8,)
*/