-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__84a0a1', 'molecule_i_1', 't1__4c6b90');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__c910a1', 'molecule_i_1', 't1__4c6b90');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'a2y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 't1__4c6b90');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 't1__4c6b90');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'sr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 't1__4c6b90');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'nprmdposii');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '6klfa9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__aa15ed', 'molecule_i_1', 't1__4c6b90');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 't1__4c6b90');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 't1__4c6b90');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 't1__4c6b90');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', '5s5b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 't1__4c6b90');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR004_8_9', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__3b7195', 'molecule_i_1', 'm52zbu');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__43e867', 'molecule_i_1', 'rqro');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__84a0a1', 't1__84a0a1', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__84a0a1', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_3', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_8', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_9', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_10', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aa15ed', '_', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aa15ed', 'atom_id_8', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aa15ed', 'atom_id_10', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aa15ed', 't1__c910a1', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aa15ed', 'atom_id_11', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aa15ed', 'atom_id_15', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__84a0a1', 'atom_id_13', 't2__3b7195');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__84a0a1', 'G', 't2__43e867');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__aa15ed', 'atom_id_16', 't2__3b7195');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'atom_id_14', 'TR004_8_9');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'atom_id_15', 'TR004_8_9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR004_8_9';

/*
Gold Result:
('t1__4c6b90',)
('sr',)
*/

-- Prediction Query
SELECT T3.element FROM bond AS T1 JOIN connected AS T2 ON T1.bond_id = T2.bond_id JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_id = 'TR004_8_9';

/*
Prediction Result:
('t1__4c6b90',)
('t1__4c6b90',)
('sr',)
('sr',)
('sr',)
('sr',)
('sr',)
('sr',)
('t1__4c6b90',)
('t1__4c6b90',)
('t1__4c6b90',)
('t1__4c6b90',)
('t1__4c6b90',)
('t1__4c6b90',)
('t1__4c6b90',)
('t1__4c6b90',)
*/