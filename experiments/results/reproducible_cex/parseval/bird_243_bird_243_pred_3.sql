-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__fc0b29', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__0865ed', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__6470d7', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__0ca097', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'wbbp6luhvdlt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__61e836', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '5bbp0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'o3o9hl72klex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'au2dwy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'u78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'rkf9vqx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', '1vy9uxj4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'ph2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'qcx5');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__39543d', 'molecule_i_1', 'u7');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', 'atom_id_1', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', 't3__6470d7', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 't1__fc0b29', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__0ca097', 'atom_id_1', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't3__6470d7', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 't1__0865ed', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', 't3__0ca097', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'atom_id_1', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', 'atom_id_9', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'O', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'Q', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', '_', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', '_', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'C', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_1', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'O', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__61e836', 'O', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__61e836', 't3__0ca097', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'atom_id_1', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', 'A', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'atom_id_13', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'atom_id_14', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', 'atom_id_15', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'atom_id_15', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'A', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__61e836', 't3__6470d7', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__61e836', 'atom_id_16', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'atom_id_9', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', 'atom_id_17', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'C', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 't3__0ca097', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__61e836', 'atom_id_14', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__61e836', 't1__fc0b29', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'atom_id_16', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', 'atom_id_16', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'atom_id_18', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', 'atom_id_14', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 't3__6470d7', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__61e836', 'atom_id_18', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__61e836', 'atom_id_19', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', 't1__fc0b29', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'atom_id_20', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__fc0b29', 't1__0865ed', 't2__39543d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__6470d7', 'atom_id_21', 't2__39543d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
*/

-- Prediction Query
SELECT bond.bond_id FROM atom AS atom1 INNER JOIN connected AS connected1 ON atom1.atom_id = connected1.atom_id INNER JOIN bond ON connected1.bond_id = bond.bond_id WHERE atom1.element = 'p' AND connected1.atom_id2 IN (SELECT atom2.atom_id FROM atom AS atom2 WHERE atom2.element = 'n');

/*
Prediction Result:
('t2__39543d',)
('t2__39543d',)
('t2__39543d',)
*/