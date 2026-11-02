-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__225d8f', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'A', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'A', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't2__0838c0', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__0838c0', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't2__0838c0', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't1__225d8f', 't2__87e006');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't1__225d8f', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 't1__225d8f', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'Q', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('H', 'P', 'ca');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__225d8f', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__0838c0', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('P', '5k5swwqcgs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Gold Result:
('4',)
*/

-- Prediction Query
SELECT MAX(T1.label) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'ca';

/*
Prediction Result:
('e4',)
*/