-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t_s_9bf4d2', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't_s_9bf4d2', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 't_s_9bf4d2', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't_s_9bf4d2', 't_s_91ea16');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't_s_9bf4d2', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 't_s_9bf4d2', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('D', 't_s_9bf4d2', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('H', 't_s_9bf4d2', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 't_s_9bf4d2', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('L', 't_s_9bf4d2', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('F', 't_s_9bf4d2', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('`', 't_s_9bf4d2', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=' ORDER BY T.molecule_id LIMIT 5;

/*
Gold Result:
('t_s_9bf4d2',)
*/

-- Prediction Query
SELECT T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' ORDER BY T2.label, T1.bond_id NULLS LAST, T2.molecule_id NULLS LAST LIMIT 5;

/*
Prediction Result:
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
*/