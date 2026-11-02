-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__baecbe', 'molecule_i_1', 't2__910383');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 't2__910383');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__a349f3', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 't2__910383');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 't2__910383');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'molecule_i_1', 't2__910383');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'dpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'nw6klf');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', '76nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '4nrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'fqyp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__99afe4', 'molecule_i_1', 'ryytoo3');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'lex');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR144_8_19', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__347884', 'molecule_i_1', 'bbp02eutliqa');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__baecbe', 't1__baecbe', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__baecbe', 'atom_id_2', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__a349f3', 't1__a349f3', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_2', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__baecbe', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_8', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__baecbe', 't1__a349f3', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__baecbe', 'atom_id_9', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__baecbe', 'atom_id_10', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__baecbe', 'atom_id_11', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__baecbe', 'atom_id_12', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__baecbe', 'atom_id_13', 'TR144_8_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__baecbe', 'A', 't1__347884');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__baecbe', 'atom_id_15', 'TR144_8_19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR144_8_19';

/*
Gold Result:
('t2__910383',)
('t2__910383',)
('a2ypuzhsrwbb',)
('hvdltt',)
('hvdltt',)
('hvdltt',)
('t2__910383',)
('t2__910383',)
('t2__910383',)
('t2__910383',)
('t2__910383',)
('t2__910383',)
('t2__910383',)
*/

-- Prediction Query
SELECT t1.element AS element1, t2.element AS element2 FROM atom AS t1 JOIN connected AS c ON t1.atom_id = c.atom_id JOIN atom AS t2 ON t2.atom_id = c.atom_id2 WHERE c.bond_id = 'TR144_8_19';

/*
Prediction Result:
('t2__910383', 't2__910383')
('t2__910383', 't2__910383')
('a2ypuzhsrwbb', 'a2ypuzhsrwbb')
('hvdltt', 't2__910383')
('hvdltt', 't2__910383')
('hvdltt', 'dpos')
('t2__910383', 'a2ypuzhsrwbb')
('t2__910383', 'nw6klf')
('t2__910383', '00t5c4ecigc')
('t2__910383', '76nium52')
('t2__910383', '4nrq')
('t2__910383', 'fqyp')
('t2__910383', 'lex')
*/