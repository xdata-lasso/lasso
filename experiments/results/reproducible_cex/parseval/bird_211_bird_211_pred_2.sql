-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__cffdd0', 't1__129026', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__1d5135', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', 'lbn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__1d5135', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__129026', 'klfa9000t');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'C', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't1__129026', 'e376nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 't1__129026', 'uo4nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't1__129026', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'O', 'ut');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'A', '1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'A', 'oo3o9hl72kl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'C', 'ji7zwau2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__bbe4aa', 't1__129026', 'yrq13p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'A', '0b4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__1d5135', 'rkf9vqx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'C', 'f8jegd21vy9u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't1__129026', 'lph2gn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'A', 'qcx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'C', '3d');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__129026', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__1d5135', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 'rwbbp6luhvd');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__dd3c09', 'hncprjtu0dz');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__1d5135', 'gu7v');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 't1__cffdd0', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_2', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_3', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_4', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'A', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', '@', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_7', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_8', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_4', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_9', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_10', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_11', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_7', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_12', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_13', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_12', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__bbe4aa', 'atom_id_7', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__bbe4aa', 'atom_id_9', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_9', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_15', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__bbe4aa', 'atom_id_15', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__bbe4aa', 'atom_id_10', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_16', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_17', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__bbe4aa', 'atom_id_12', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__bbe4aa', 'atom_id_16', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_18', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_19', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__bbe4aa', 'atom_id_17', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'A', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__cffdd0', 'atom_id_20', 'bond_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.label = '-';

/*
Gold Result:
('t1__cffdd0',)
('t3__bbe4aa',)
*/

-- Prediction Query
SELECT T3.atom_id, T3.atom_id2 FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T2.atom_id = T3.atom_id WHERE T1.label = '-';

/*
Prediction Result:
('t1__cffdd0', 'A')
('t1__cffdd0', 'atom_id_10')
('t1__cffdd0', 'atom_id_11')
('t1__cffdd0', 'atom_id_12')
('t1__cffdd0', 'atom_id_13')
('t1__cffdd0', 'atom_id_15')
('t1__cffdd0', 'atom_id_16')
('t1__cffdd0', 'atom_id_17')
('t1__cffdd0', 'atom_id_18')
('t1__cffdd0', 'atom_id_19')
('t1__cffdd0', 'atom_id_2')
('t1__cffdd0', 'atom_id_20')
('t1__cffdd0', 'atom_id_3')
('t1__cffdd0', 'atom_id_4')
('t1__cffdd0', 'atom_id_7')
('t1__cffdd0', 'atom_id_8')
('t1__cffdd0', 'atom_id_9')
('t1__cffdd0', 't1__cffdd0')
('t3__bbe4aa', 'atom_id_10')
('t3__bbe4aa', 'atom_id_12')
('t3__bbe4aa', 'atom_id_15')
('t3__bbe4aa', 'atom_id_16')
('t3__bbe4aa', 'atom_id_17')
('t3__bbe4aa', 'atom_id_7')
('t3__bbe4aa', 'atom_id_9')
*/