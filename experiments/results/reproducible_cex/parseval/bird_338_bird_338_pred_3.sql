-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__4f0eb9', 'TR012', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'TR012', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__b59596', 'TR012', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'TR012', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'TR012', 'c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'C', 'c');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR012', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__c532d0', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__5d093f', 'u7');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '5k5swwqcgs');

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

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 't1__c532d0', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', 'TR012', 't3__5cc18b');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 'TR012', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'C', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.molecule_id = 'TR012' AND T3.bond_type = '=' AND T1.element = 'c';

/*
Gold Result:
('t1__4f0eb9',)
('t1__4f0eb9',)
('t1__4f0eb9',)
('t1__4f0eb9',)
('t1__4f0eb9',)
('t1__4f0eb9',)
('t1__4f0eb9',)
('t1__4f0eb9',)
('t1__4f0eb9',)
('t1__4f0eb9',)
('t1__4f0eb9',)
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
('t1__b59596',)
('t1__b59596',)
('t1__b59596',)
('t1__b59596',)
('t1__b59596',)
('t1__b59596',)
('t1__b59596',)
('t1__b59596',)
('t1__b59596',)
('t1__b59596',)
('t1__b59596',)
('G',)
('G',)
('G',)
('G',)
('G',)
('G',)
('G',)
('G',)
('G',)
('G',)
('G',)
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
*/

-- Prediction Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T1.element = 'c' AND T2.bond_type = ' = ' AND T2.molecule_id = 'TR012';

/*
Prediction Result:
*/