-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__3097dc', 't1__ffe8d7', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__ffe8d7', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__ffe8d7', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__ffe8d7', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', '@', 't1__410609');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'H', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'B', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'L', 't1__410609');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('E', 'D', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__ffe8d7', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__e05d99', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', 't2__88f661');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('L', 't2__88f661');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', 't2__88f661');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) AS atomnums_h FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND T1.element = 'h';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(T2.atom_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'H' AND T1.label = '+';

/*
Prediction Result:
(0,)
*/