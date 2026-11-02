-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__540083', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__540083', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__1e5e87', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'Q', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'O', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', '_', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__540083', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__540083', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__540083', 'ca');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't1__540083', 't1__e7c0b3');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 't1__540083', 'ca');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__540083', 't2__6bfbea');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_3', 't2__30b652');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__1e5e87', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_7', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_9', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__11', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__13', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__14', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__15', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__16', 'mol_f39f10');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__15bbb2', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule__18', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label AS flag_carcinogenic FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca';

/*
Gold Result:
('t2__6bfbea',)
('t2__6bfbea',)
('5k5swwqcgs',)
('9n8',)
('4',)
('gu7v',)
('t2__6bfbea',)
('t2__6bfbea',)
('t2__6bfbea',)
('t2__6bfbea',)
*/

-- Prediction Query
SELECT label FROM molecule WHERE molecule_id IN (SELECT molecule_id FROM atom WHERE element = 'ca');

/*
Prediction Result:
('4',)
('9n8',)
('gu7v',)
('5k5swwqcgs',)
('t2__6bfbea',)
*/