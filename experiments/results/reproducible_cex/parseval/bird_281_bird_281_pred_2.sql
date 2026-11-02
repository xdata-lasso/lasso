-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('IAAAAA4', 't1__338002', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAAAA4', 't1__356d4d', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('CAAAAA4', 'A', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAAAAA4', 'A', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('EAAAAA4', 't1__338002', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__338002', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAQAAAA', 't1__338002', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('CA_AAAA', 't1__356d4d', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('4', 't1__338002', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 't1__356d4d', 't1__140306');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@QAAAA4', '@', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_AAAAA4', 't1__338002', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B_AAAA4', 'B', 'hria2ypuzhs');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__338002', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__356d4d', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__64233e', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, -1) = '4' AND LENGTH(T1.atom_id) = 7;

/*
Gold Result:
('t1__140306',)
('gu7v',)
('e4',)
('hria2ypuzhs',)
*/

-- Prediction Query
SELECT T2.element FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' AND SUBSTRING(T2.atom_id, 7, 1) = '4';

/*
Prediction Result:
('t1__140306',)
('t1__140306',)
('gu7v',)
('e4',)
('hria2ypuzhs',)
*/