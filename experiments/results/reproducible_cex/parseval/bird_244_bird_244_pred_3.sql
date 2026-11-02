-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__a9fb4a', 't1__ce6798');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 't1__ce6798');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 't1__ce6798');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__a9fb4a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 't1__a9fb4a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 't1__a9fb4a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 't1__a9fb4a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 't1__a9fb4a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 't1__a9fb4a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 'C', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 't1__a9fb4a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 't1__a9fb4a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 't1__a9fb4a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', 'C', '5k5swwqcgsk');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 't1__a9fb4a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 't1__a9fb4a', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_17', 't1__a9fb4a', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.label FROM molecule AS T1 INNER JOIN (SELECT T.molecule_id, COUNT(T.bond_type) FROM bond AS T WHERE T.bond_type = '=' GROUP BY T.molecule_id ORDER BY COUNT(T.bond_type) DESC, T.molecule_id NULLS LAST LIMIT 1) AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
('t1__ce6798',)
*/

-- Prediction Query
SELECT m.label FROM molecule AS m INNER JOIN bond AS b ON m.molecule_id = b.molecule_id WHERE b.bond_type = ' = ' GROUP BY m.molecule_id, m.label ORDER BY COUNT(*) DESC, m.label NULLS LAST LIMIT 1;

/*
Prediction Result:
*/