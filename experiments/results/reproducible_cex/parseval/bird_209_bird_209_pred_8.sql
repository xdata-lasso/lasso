-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__3b4f43', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'te');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'molecule_i_1', 'ie5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', 'a9000t5c4eci');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'p5s5bbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'o9hl72kl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '7zwau2dwyr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', '8d99rljsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'yp5qi2rk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '8pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'd21vy9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'gndqwnqc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'rjtu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', '79fjgq8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'qv0gcb98ozk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', '6vck6ah0f8js');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'q7x');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 'molecule_i_1', 'xa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 'molecule_i_1', 'fdrz16n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__c5cd92', 'molecule_i_1', 'jai');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 'molecule_i_1', 'rg');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 'molecule_i_1', 'yzt1afgog');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', 'ia2yp');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__74dd94', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__0fc0e6', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', 'zbuo4nrqrof');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__4e0882', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'molecule_i_1', 't1__07f5cf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 'molecule_i_1', 't1__07f5cf');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 't2__3b4f43', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_2', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_3', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_4', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_2', 't1__74dd94');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'atom_id_3', 't1__74dd94');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', '?', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_8', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_8', 't1__74dd94');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_4', 't1__74dd94');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_9', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_10', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_11', 't1__74dd94');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'atom_id_2', 't1__74dd94');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_12', 't2__4e0882');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'A', 't2__4e0882');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_13', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_14', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_15', 't2__4e0882');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_16', 't2__4e0882');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', '@', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_17', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_18', 't2__4e0882');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_19', 't2__4e0882');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_20', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_21', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_22', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_23', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_24', 't2__4e0882');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_25', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_27', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__3b4f43', 'atom_id_28', 'Q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T3.element = 'te';

/*
Gold Result:
('t1__07f5cf',)
('ia2yp',)
('zbuo4nrqrof',)
*/

-- Prediction Query
SELECT DISTINCT b.bond_type FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id JOIN bond AS b ON c.bond_id = b.bond_id WHERE a.element = 'cl';

/*
Prediction Result:
*/