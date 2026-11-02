-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'molecule_i_1', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_2', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'rwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t_s_71442f', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'molecule_i_1', 'nprmdposii');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t_s_b71d09', 'molecule_i_1', 'ia2yp');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_1', 'TR000_2', 't_s_b71d09');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_2', 'TR000_2', 't_s_b71d09');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_3', 'TR000_2', 't_s_b71d09');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_3', 't_s_71442f', 't_s_b71d09');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_5', 'TR000_2', 't_s_b71d09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_id FROM connected AS T WHERE T.atom_id2 = 'TR000_2';

/*
Gold Result:
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
*/

-- Prediction Query
SELECT T1.bond_id FROM connected AS T1 INNER JOIN connected AS T2 ON T1.atom_id2 = T2.atom_id2 WHERE T2.atom_id2 = 'TR000_2';

/*
Prediction Result:
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
('t_s_b71d09',)
*/