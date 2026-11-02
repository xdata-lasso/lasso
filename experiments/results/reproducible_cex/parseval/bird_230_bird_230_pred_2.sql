-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'TR060', 't2__0a792b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'TR060', 't2__0a792b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'TR060', 't2__0a792b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'A', 't2__0a792b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 't2__0a792b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'A', 't2__0a792b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'TR060', 't2__0a792b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 't1__359d7b', 't2__0a792b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'TR060', 't2__0a792b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'TR060', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR060', 't1__eb0d7a');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__359d7b', 't1__eb0d7a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR060';

/*
Gold Result:
('t2__0a792b', 't1__eb0d7a')
(None, 't1__eb0d7a')
*/

-- Prediction Query
SELECT T2.element, T1.label FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR060';

/*
Prediction Result:
('t2__0a792b', 't1__eb0d7a')
('t2__0a792b', 't1__eb0d7a')
('t2__0a792b', 't1__eb0d7a')
('t2__0a792b', 't1__eb0d7a')
('t2__0a792b', 't1__eb0d7a')
(None, 't1__eb0d7a')
*/