-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR018', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 'TR018', 't1__3530a0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 'TR018', 't1__3530a0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'TR018', 't1__3530a0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'TR018', 't1__3530a0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 'TR018', 't1__3530a0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 'TR018', 't1__3530a0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'TR018', 'C');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'TR018', 'C');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 'TR018', '!');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 'TR018', 'G');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'TR018', 'G');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'TR018', '!');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 'TR018', 'C');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', 'TR018', 'C');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 'TR018', '!');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 'TR018', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_17', 'TR018', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_18', 'TR018', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_19', 'TR018', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_20', 'TR018', '8c4pgu7vfe');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_21', 'TR018', 't1__3530a0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_22', 'TR018', 't1__3530a0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_23', 'TR018', 't1__3530a0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_24', 'TR018', 't1__3530a0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_25', 'TR018', 't1__3530a0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_26', 'TR018', 't1__3530a0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM (SELECT T1.bond_type, COUNT(T1.molecule_id) FROM bond AS T1 WHERE T1.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.molecule_id) DESC, T1.bond_type NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
('t1__3530a0',)
*/

-- Prediction Query
SELECT T1.bond_type, T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR010' GROUP BY T1.bond_type ORDER BY COUNT(T1.bond_type) DESC, T1.bond_type NULLS LAST, T2.label NULLS LAST LIMIT 1;

/*
Prediction Result:
*/