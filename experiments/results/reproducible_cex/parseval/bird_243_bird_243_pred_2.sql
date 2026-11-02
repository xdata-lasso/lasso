-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__6fcaae', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__f52425', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__fe602e', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__c500fb', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'wbbp6luhvdlt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'posiie5unw6k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', '4ecigce376n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'molecule_i_1', 'zbuo4nrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__3244ac', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', 's5bbp02e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'a11ry');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'oo3o9hl72kl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '2dwyrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'yu78');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', '0b4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'kf9vq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'pz0f8jegd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'j4hwbd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'gndqwnqc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', 'tu0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', '9fjgq8n2f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 'molecule_i_1', '0gcb98');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 'molecule_i_1', '3zb');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__c99956', 'molecule_i_1', 'u7');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 'atom_id_1', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 't3__fe602e', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 't1__6fcaae', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__c500fb', 'atom_id_1', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't3__fe602e', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 't1__f52425', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 't3__c500fb', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't1__f52425', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 't1__f52425', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't3__fe602e', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'A', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'A', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 'G', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't3__fe602e', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', '?', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 't3__c500fb', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3244ac', '?', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3244ac', 't3__c500fb', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'atom_id_12', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 'atom_id_13', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', '?', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'atom_id_14', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 'A', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'G', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 't3__fe602e', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3244ac', 'C', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3244ac', 'atom_id_15', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'atom_id_16', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 'C', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'atom_id_17', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'atom_id_13', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3244ac', 'O', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3244ac', 'atom_id_18', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'atom_id_19', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 't2__3244ac', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'atom_id_20', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 'atom_id_21', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'atom_id_21', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3244ac', 'atom_id_12', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3244ac', 'atom_id_21', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 'atom_id_22', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'atom_id_23', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6fcaae', 'atom_id_24', 't2__c99956');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__fe602e', 'atom_id_25', 't2__c99956');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
*/

-- Prediction Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element IN ('p', 'n');

/*
Prediction Result:
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
('t2__c99956',)
*/