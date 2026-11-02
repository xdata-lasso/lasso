-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'A', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'A', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'A', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'A', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'A', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'B', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'B', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'B', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'D', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'D', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'D', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 't1__8500ab', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', '@', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_29', 't1__8500ab', 'o');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_30', 't1__8500ab', 'o');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__8500ab', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', 'e4');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__8500ab', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 't1__8500ab', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 't1__8500ab', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 't1__8500ab', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 't1__8500ab', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__8500ab', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 't1__8500ab', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(oxygen_count) FROM (SELECT T1.molecule_id, COUNT(T1.element) AS oxygen_count FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '-' AND T1.element = 'o' GROUP BY T1.molecule_id) AS oxygen_counts;

/*
Gold Result:
(112.0,)
*/

-- Prediction Query
SELECT AVG(CASE WHEN a.element = 'o' THEN 1 ELSE 0 END) AS average_oxygen_atoms FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id JOIN bond AS b ON c.bond_id = b.bond_id WHERE b.bond_type = '-';

/*
Prediction Result:
(None,)
*/