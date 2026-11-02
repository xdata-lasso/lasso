-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__596f5c', 't1__6716a1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't2__596f5c', 't1__6716a1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', '?', 't1__6716a1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'A', 't1__6716a1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't2__596f5c', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'H', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', '@', '_');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'H', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't2__596f5c', 'C');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't2__596f5c', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'A', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'I', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'H', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'O', 'A');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__596f5c', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', 'n8c4pgu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id, T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
('t2__596f5c', 't1__6716a1')
('t2__596f5c', None)
('@', '_')
('t2__596f5c', 'C')
('t2__596f5c', 'A')
*/

-- Prediction Query
SELECT T1.label, T2.element FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+';

/*
Prediction Result:
('+', 't1__6716a1')
('+', 't1__6716a1')
('+', None)
('+', '_')
('+', 'C')
('+', 'A')
*/