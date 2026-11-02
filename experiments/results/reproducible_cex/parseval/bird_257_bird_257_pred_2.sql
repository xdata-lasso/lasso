-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__8045ec', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__789d88', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__9a3afe', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__99d876', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 't1__9c0bef');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'molecule_i_1', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'swwqcgsk');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 'molecule_i_1', 'hria2ypuzhs');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8045ec', 't2__9a3afe', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't2__9a3afe', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__99d876', 't2__9a3afe', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 't2__9a3afe', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('B', 'O', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_11', 'O', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('B', 'A', 'bond_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 's';

/*
Gold Result:
('t2__9a3afe',)
*/

-- Prediction Query
SELECT connected.atom_id2 FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id WHERE atom.element = 's';

/*
Prediction Result:
('t2__9a3afe',)
('t2__9a3afe',)
('t2__9a3afe',)
*/