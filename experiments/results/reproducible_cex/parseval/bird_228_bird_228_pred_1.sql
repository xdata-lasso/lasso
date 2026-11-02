-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t_s_31c38a', 'TR206', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'TR206', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'TR206', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'TR206', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'TR206', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('H', 'TR206', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'TR206', 'h');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR206', '5k5swwqcgs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.element = 'h' THEN T.atom_id ELSE NULL END) AS REAL) * 100 / COUNT(T.atom_id) FROM atom AS T WHERE T.molecule_id = 'TR206';

/*
Gold Result:
(85.71428571428571,)
*/

-- Prediction Query
SELECT ROUND(100.0 * SUM(CASE WHEN element = 'h' THEN 1 ELSE 0 END) / COUNT(atom_id), 4) AS percent FROM atom WHERE molecule_id = 'TR206';

/*
Prediction Result:
(85.7143,)
*/