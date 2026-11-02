-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_3ac4ef', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__1b7225', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('H', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'molecule_i_1', 'bbp02eutliqa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a', 'molecule_i_1', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__b26db7', 'molecule_i_1', 'au2dwy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'molecule_i_1', 'b4yp5qi');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', '9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'd21vy9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'n2f3dqv0g');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'molecule_i_1', '9');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '9n8');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__c691f2', 'molecule_i_1', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'molecule_i_1', 'sr');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'molecule_i_1', 'a9');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 'molecule_i_1', '76nium52');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b', 'molecule_i_1', 'zbuo4nrqrof');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('P', 'molecule_i_1', 'yytoo');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'molecule_i_1', 'x58pz');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'gndqwnqc');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('*', 'molecule_i_1', 'x5hncprjtu0');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('!', 'molecule_i_1', 'k3zbily');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('''', 'molecule_i_1', 'jswwlq7xb');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_3ac4ef', 'con_3ac4ef', 't1__c691f2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1b7225', 't1__1b7225', 't1__c691f2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_3ac4ef', 'atom_id_3', 't1__c691f2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't1__1b7225', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('H', 'H', '?');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_3ac4ef', 'A', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('!', 'A', 'P');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('a', 'A', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_3ac4ef', 't1__1b7225', 'b');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1b7225', 'H', 't1__c691f2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b26db7', 'H', 't1__c691f2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_3ac4ef', 'atom_id_9', '_');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1b7225', 't1__b26db7', 't1__c691f2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b26db7', 'atom_id_10', 't1__c691f2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_3ac4ef', 'atom_id_11', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_3', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_3ac4ef', 'atom_id_13', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_13', '*');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('D', 'atom_id_9', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_3ac4ef', '@', '*');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1b7225', '!', 't1__c691f2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_3ac4ef', 'atom_id_10', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__1b7225', 'a', 't1__c691f2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_3', 'atom_id_10', '*');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_3', 'atom_id_11', '''');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(34.61538461538461,)
*/

-- Prediction Query
SELECT (COUNT(CASE WHEN a.element = (SELECT element FROM atom GROUP BY element ORDER BY COUNT(atom_id) DESC, element NULLS LAST LIMIT 1) THEN 1 ELSE NULL END) * 100.0 / COUNT(b.bond_id)) AS percentage FROM bond AS b JOIN atom AS a ON b.molecule_id = a.molecule_id;

/*
Prediction Result:
(7.142857142857143,)
*/