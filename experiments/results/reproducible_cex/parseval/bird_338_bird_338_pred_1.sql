-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__9ac29a', 'TR012', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'TR012', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__cf62c8', 'TR012', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'TR012', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'TR012', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', '@', 'c');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR012', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__ab36fc', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__a308a8', 'u7');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 't1__ab36fc', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', 'TR012', 't3__0b95c3');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', '@', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.molecule_id = 'TR012' AND T3.bond_type = '=' AND T1.element = 'c';

/*
Gold Result:
('t1__9ac29a',)
('t1__9ac29a',)
('t1__9ac29a',)
('t1__9ac29a',)
('t1__9ac29a',)
('t1__9ac29a',)
('t1__9ac29a',)
('t1__9ac29a',)
('t1__9ac29a',)
('t1__9ac29a',)
('t1__9ac29a',)
('I',)
('I',)
('I',)
('I',)
('I',)
('I',)
('I',)
('I',)
('I',)
('I',)
('I',)
('t1__cf62c8',)
('t1__cf62c8',)
('t1__cf62c8',)
('t1__cf62c8',)
('t1__cf62c8',)
('t1__cf62c8',)
('t1__cf62c8',)
('t1__cf62c8',)
('t1__cf62c8',)
('t1__cf62c8',)
('t1__cf62c8',)
('O',)
('O',)
('O',)
('O',)
('O',)
('O',)
('O',)
('O',)
('O',)
('O',)
('O',)
('_',)
('_',)
('_',)
('_',)
('_',)
('_',)
('_',)
('_',)
('_',)
('_',)
('_',)
*/

-- Prediction Query
SELECT a.atom_id FROM atom AS a JOIN bond AS b ON a.molecule_id = b.molecule_id JOIN connected AS c ON b.bond_id = c.bond_id WHERE a.element = 'c' AND b.bond_type = '=' AND a.molecule_id = 'TR012';

/*
Prediction Result:
*/