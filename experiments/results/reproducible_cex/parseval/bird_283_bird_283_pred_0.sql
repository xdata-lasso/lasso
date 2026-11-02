-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__0b3a06', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__0b3a06', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__78329d', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'C', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'G', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'G', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__0b3a06', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__0b3a06', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__0b3a06', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't1__0b3a06', 't1__77c0b1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 't1__0b3a06', 'ca');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__0b3a06', 't2__e5cfb9');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_3', 't2__1e290e');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__78329d', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_7', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_8', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__10', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__11', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__12', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__13', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__14', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__986aab', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__16', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label AS flag_carcinogenic FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca';

/*
Gold Result:
('t2__e5cfb9',)
('t2__e5cfb9',)
('5k5swwqcgs',)
('mol_f39f10',)
('9n8',)
('9n8',)
('t2__e5cfb9',)
('t2__e5cfb9',)
('t2__e5cfb9',)
('t2__e5cfb9',)
*/

-- Prediction Query
SELECT CASE WHEN T4.label = '+' THEN 'Yes' ELSE 'No' END AS Is_Carcinogenic FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id INNER JOIN molecule AS T4 ON T1.molecule_id = T4.molecule_id WHERE T1.element = 'ca';

/*
Prediction Result:
*/