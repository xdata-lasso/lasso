-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_cbfacb', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__73fd0b', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('4', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('0', 'molecule_i_1', 'bbp02eutliqa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('5', 'molecule_i_1', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', '3pyu78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__6c2470', 'molecule_i_1', 'l0b4y');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 'j4hwbdvlph');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'molecule_i_1', 'nd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'qcx5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'molecule_i_1', 'z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('"', 'molecule_i_1', 'gq8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'kn6vck6ah0f8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'wlq7xb');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '9n8');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__c98897', 'molecule_i_1', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', 'sr');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('%', 'molecule_i_1', 'a9');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'molecule_i_1', '76nium52');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', 'zbuo4nrqrof');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('S', 'molecule_i_1', 'yytoo');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('!', 'molecule_i_1', 'ex1');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('c', 'molecule_i_1', 'f8jegd2');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'f3dqv0gc');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES (')', 'molecule_i_1', 'xa');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_cbfacb', 'con_cbfacb', 't1__c98897');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__73fd0b', 't1__73fd0b', 't1__c98897');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_cbfacb', 'atom_id_3', 't1__c98897');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('4', 't1__73fd0b', '%');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('D', 'D', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_cbfacb', '4', '%');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('0', '4', 'S');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('5', '4', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_cbfacb', 'atom_id_8', '%');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__73fd0b', 'atom_id_3', 't1__c98897');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6c2470', '4', 't1__c98897');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_cbfacb', 't1__6c2470', 'S');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__73fd0b', '4', 't1__c98897');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__6c2470', '5', 't1__c98897');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_cbfacb', 'atom_id_10', 'S');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'D', 'c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '@', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_cbfacb', 'D', 'S');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('!', 't1__6c2470', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('"', 'A', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_cbfacb', '"', '%');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__73fd0b', 'atom_id_8', 't1__c98897');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_cbfacb', 'atom_id_15', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__73fd0b', 'atom_id_16', 't1__c98897');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_3', 't1__6c2470', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('atom_id_3', 'atom_id_3', 't1__c98897');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(38.46153846153846,)
*/

-- Prediction Query
WITH ElementCombination AS (SELECT T1.element AS element1, T2.element AS element2 FROM atom AS T1 INNER JOIN connected AS C ON T1.atom_id = C.atom_id INNER JOIN atom AS T2 ON C.atom_id2 = T2.atom_id), MostCommonCombination AS (SELECT element1, element2, COUNT(*) AS combo_count FROM ElementCombination GROUP BY element1, element2 ORDER BY combo_count DESC, element1 NULLS LAST, element2 NULLS LAST LIMIT 1), TotalBonds AS (SELECT COUNT(*) AS total_bonds FROM bond), BondsInCommonCombination AS (SELECT COUNT(*) AS common_bonds FROM connected AS C INNER JOIN atom AS A1 ON C.atom_id = A1.atom_id INNER JOIN atom AS A2 ON C.atom_id2 = A2.atom_id INNER JOIN MostCommonCombination AS MCC ON A1.element = MCC.element1 AND A2.element = MCC.element2) SELECT CAST(common_bonds AS REAL) * 100 / total_bonds AS percentage FROM TotalBonds CROSS JOIN BondsInCommonCombination;

/*
Prediction Result:
(10.0,)
*/