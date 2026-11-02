-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__95609c', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__95609c', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'O', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'G', 'rwbbp6luhvd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'O', 'tti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__95609c', 'bnp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__95609c', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__95609c', 'ie5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't1__95609c', 'nw6klf');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 't1__95609c', 'a9000t5c4eci');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__95609c', 'zbuo4nrqrof');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__95609c', 't1__d1410e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', '@', 'h');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__95609c', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__b8fcb8', 'gce376nium52');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T1.element = 'h' THEN T2.molecule_id ELSE NULL END) AS REAL) * 100 / COUNT(T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(20.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'h';

/*
Prediction Result:
(100.0,)
*/