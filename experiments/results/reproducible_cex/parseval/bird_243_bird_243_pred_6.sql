-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__9fd291', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__9d7aa7', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__872a39', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__e215e5', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'wbbp6luhvdlt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__a5c7d9', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '5bbp0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'o3o9hl72klex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'au2dwy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'u78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'rkf9vqx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', '1vy9uxj4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'h2gndqwnqcx5');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__aed03a', 'molecule_i_1', 'u7');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 'atom_id_1', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 't3__872a39', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 't1__9fd291', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e215e5', 'atom_id_1', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't3__872a39', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 't1__9d7aa7', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 't3__e215e5', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Q', 'atom_id_1', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 'atom_id_9', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'G', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'Q', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'O', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 'O', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'C', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_1', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'G', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a5c7d9', 'G', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a5c7d9', 't3__e215e5', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'atom_id_1', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 'A', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'atom_id_13', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'atom_id_14', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 'atom_id_15', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'atom_id_15', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'A', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a5c7d9', 't3__872a39', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a5c7d9', 'atom_id_16', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'atom_id_9', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 'atom_id_17', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'C', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 't3__e215e5', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a5c7d9', 'atom_id_14', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a5c7d9', 't1__9fd291', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'atom_id_16', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 'atom_id_16', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'atom_id_18', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 'atom_id_14', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 't3__872a39', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a5c7d9', 'atom_id_18', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a5c7d9', 'atom_id_19', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 't1__9fd291', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'atom_id_20', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9fd291', 't1__9d7aa7', 't2__aed03a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__872a39', 'Q', 't2__aed03a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
*/

-- Prediction Query
SELECT T1.bond_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id INNER JOIN atom AS T4 ON T2.atom_id2 = T4.atom_id WHERE T3.element = 'p' AND T4.element = 'n';

/*
Prediction Result:
('t2__aed03a',)
('t2__aed03a',)
('t2__aed03a',)
*/