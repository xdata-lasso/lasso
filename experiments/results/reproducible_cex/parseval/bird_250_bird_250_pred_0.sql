-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__5a9754', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_2', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__710566', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__5a9754', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 't1__5a9754', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 't1__710566', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 't1__5a9754', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't1__5a9754', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 't1__5a9754', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't1__5a9754', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 't1__5a9754', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 't1__5a9754', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__5a9754', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.molecule_id FROM (SELECT T3.molecule_id, COUNT(T1.bond_type) FROM bond AS T1 INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.label = '+' AND T1.bond_type = '=' GROUP BY T3.molecule_id ORDER BY COUNT(T1.bond_type) DESC, T3.molecule_id NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
('t1__5a9754',)
*/

-- Prediction Query
SELECT T1.label FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' AND T2.bond_type = '=' GROUP BY T1.label ORDER BY COUNT(T2.bond_type) DESC, T1.label NULLS LAST LIMIT 1;

/*
Prediction Result:
('+',)
*/