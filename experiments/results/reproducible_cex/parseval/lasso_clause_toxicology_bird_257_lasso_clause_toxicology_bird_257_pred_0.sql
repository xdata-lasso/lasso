-- Schema DDL
CREATE TABLE atom (atom_id TEXT NOT NULL PRIMARY KEY, molecule_id TEXT DEFAULT NULL, element TEXT DEFAULT NULL, FOREIGN KEY (molecule_id) REFERENCES molecule (molecule_id));

CREATE TABLE bond (bond_id TEXT NOT NULL PRIMARY KEY, molecule_id TEXT DEFAULT NULL, bond_type TEXT DEFAULT NULL, FOREIGN KEY (molecule_id) REFERENCES molecule (molecule_id));

CREATE TABLE connected (atom_id TEXT NOT NULL, atom_id2 TEXT NOT NULL, bond_id TEXT DEFAULT NULL, PRIMARY KEY (atom_id, atom_id2), FOREIGN KEY (atom_id) REFERENCES atom (atom_id) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (atom_id2) REFERENCES atom (atom_id) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (bond_id) REFERENCES bond (bond_id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE molecule (molecule_id TEXT NOT NULL PRIMARY KEY, label TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__6c3e11', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__7798e9', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__df6d16', 'molecule_i_1', '8c4pgu7vfe');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'p6luhvdlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__e6c6a0', 'molecule_i_1', 's');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'molecule_i_1', 'swwqcgsk');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 'molecule_i_1', 'hria2ypuzhs');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6c3e11', 't2__df6d16', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't2__df6d16', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't2__df6d16', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6c6a0', 't2__df6d16', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 't2__df6d16', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6c6a0', 'I', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('I', 'A', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e6c6a0', 'O', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__7798e9', 'A', 'bond_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 's';

/*
Gold Result:
('t2__df6d16',)
('A',)
('I',)
('O',)
*/

-- Prediction Query
SELECT atom_id2 FROM connected JOIN atom ON connected.atom_id = atom.atom_id WHERE atom.element = 's';

/*
Prediction Result:
('t2__df6d16',)
('A',)
('t2__df6d16',)
('I',)
('O',)
('t2__df6d16',)
*/