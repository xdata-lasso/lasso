-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__d990ca', 't1__3296eb', 'br');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__3296eb', 'br');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__3296eb', 'br');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__3296eb', 'br');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__3296eb', 'br');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__3296eb', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t3__70e397', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__7e38b8', 'rwbbp6luhvd');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__3296eb', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 'C', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'C', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 'G', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'O', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 'O', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__3296eb', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('/', 't3__70e397', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't3__70e397', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 't1__3296eb', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 't3__70e397', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 't1__3296eb', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't3__70e397', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_17', 't1__3296eb', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element IN ('p', 'br');

/*
Gold Result:
(25,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T3.atom_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#' AND T3.element IN ('p', 'br');

/*
Prediction Result:
(0,)
*/