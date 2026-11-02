-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR006', 't2__f89506');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('!', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__92ef21', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__6f4ba5', 'TR006', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__26abd6', 'C', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'G', 't1__828c79');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id), T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' AND T2.molecule_id = 'TR006' GROUP BY T2.label;

/*
Gold Result:
(1, 't2__f89506')
*/

-- Prediction Query
SELECT COUNT(b.bond_id) AS double_bond_count, m.label AS molecule_label FROM bond AS b JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE b.bond_type = ' = ' AND m.molecule_id = 'TR006' GROUP BY m.label;

/*
Prediction Result:
*/