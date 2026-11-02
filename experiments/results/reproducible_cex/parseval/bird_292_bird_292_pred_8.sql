-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__151150', 'TR010a', 'C');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__a1049d', 'TR010a', 'C');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'U', 'C');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'T', 'C');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR010a', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR05', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('0', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('c', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR010', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR050a', 'rwbbp6luhvd');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__f58360', 'tilbn');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('U', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('T', '5k5swwqcgs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id BETWEEN 'TR010' AND 'TR050' AND T.element = 'c';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element LIKE 'C%' AND T2.molecule_id >= 'TR010' AND T2.molecule_id <= 'TR050';

/*
Prediction Result:
('t1__151150',)
('t1__a1049d',)
*/