-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'A', 't1__da7909');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'C', 't1__074e6c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', 't1__da7909');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'A', 't1__074e6c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 't1__da7909');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'A', 't1__074e6c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'A', 't1__da7909');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'A', 't1__074e6c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'I', 't1__da7909');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'A', 't1__074e6c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'G', 't1__da7909');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'Q', 't1__da7909');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'I', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'A', 'sn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'O', 't1__da7909');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'A', 't1__074e6c');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 't2__3070a7');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 't2__3070a7');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 't2__3070a7');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', 't2__3070a7');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', 't2__3070a7');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__2d0dc9', '9n8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 'sn';

/*
Gold Result:
('t2__3070a7',)
('5k5swwqcgs',)
*/

-- Prediction Query
SELECT DISTINCT T2.label FROM molecule AS T2 WHERE NOT T2.molecule_id IN (SELECT T1.molecule_id FROM atom AS T1 WHERE T1.element = 'Sn');

/*
Prediction Result:
('t2__3070a7',)
('5k5swwqcgs',)
('9n8',)
*/