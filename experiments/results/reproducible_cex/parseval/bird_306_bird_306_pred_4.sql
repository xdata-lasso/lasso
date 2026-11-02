-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__24e161', 't2__4f63ab');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__24e161', 't2__4f63ab');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', '?', 't2__4f63ab');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', '?', 't2__4f63ab');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__24e161', 't2__4f63ab');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__24e161', 't2__4f63ab');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', '?', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', '?', 'rwbbp6luhvd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 't1__24e161', 'tti');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__24e161', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '4');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 't1__24e161', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't1__24e161', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', '@', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('E', '@', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 't1__24e161', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 't1__24e161', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', '?', 'gu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', '?', 'e4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 't1__24e161', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('t1__24e161', 't2__4f63ab')
('t1__24e161', 'tti')
*/

-- Prediction Query
SELECT b.molecule_id, GROUP_CONCAT(DISTINCT a.element) AS elements FROM bond AS b INNER JOIN atom AS a ON b.molecule_id = a.molecule_id WHERE b.bond_type = '#' GROUP BY b.molecule_id;

/*
Prediction Result:
('t1__24e161', 't2__4f63ab,tti')
*/