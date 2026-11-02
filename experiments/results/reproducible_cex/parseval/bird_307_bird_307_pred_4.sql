-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__6590f0', 'molecule_i_1', 't2__4aecd4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 't2__4aecd4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__c2553e', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 't2__4aecd4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', 'dpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'rqrofqyp5s');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__d5f378', 'molecule_i_1', 'bbp02eutliqa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 'ytoo3o9');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR000_2_3', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__d8fbdf', 'molecule_i_1', 'gce376nium52');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6590f0', 't1__6590f0', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6590f0', 'atom_id_2', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__c2553e', 't1__c2553e', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_2', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't1__6590f0', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_6', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6590f0', 'atom_id_7', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6590f0', 'G', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6590f0', 'atom_id_6', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6590f0', 'A', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6590f0', 't1__c2553e', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6590f0', 'atom_id_8', 'TR000_2_3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6590f0', 'atom_id_9', 't1__d8fbdf');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6590f0', 'atom_id_10', 't1__d8fbdf');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6590f0', 'atom_id_12', 'TR000_2_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR000_2_3';

/*
Gold Result:
('t2__4aecd4',)
('t2__4aecd4',)
('a2ypuzhsrwbb',)
('hvdltt',)
('hvdltt',)
('hvdltt',)
('t2__4aecd4',)
('t2__4aecd4',)
('t2__4aecd4',)
('t2__4aecd4',)
('t2__4aecd4',)
('t2__4aecd4',)
('t2__4aecd4',)
*/

-- Prediction Query
SELECT a1.element AS atom1_element, a2.element AS atom2_element FROM bond AS b INNER JOIN connected AS c ON b.bond_id = c.bond_id INNER JOIN atom AS a1 ON c.atom_id = a1.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE b.bond_id = 'TR000_2_3';

/*
Prediction Result:
('t2__4aecd4', 't2__4aecd4')
('t2__4aecd4', 't2__4aecd4')
('a2ypuzhsrwbb', 'a2ypuzhsrwbb')
('hvdltt', 't2__4aecd4')
('hvdltt', 't2__4aecd4')
('hvdltt', 'dpos')
('t2__4aecd4', 'unw6klfa')
('t2__4aecd4', 'hvdltt')
('t2__4aecd4', 'dpos')
('t2__4aecd4', 't2__4aecd4')
('t2__4aecd4', 'a2ypuzhsrwbb')
('t2__4aecd4', '4')
('t2__4aecd4', 'ytoo3o9')
*/