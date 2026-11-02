-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__41635d', 't1__02b7ce', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__02b7ce', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__02b7ce', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__02b7ce', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', '@', 't1__49a480');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'D', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'H', 'h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', '`', 't1__49a480');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('F', 'F', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__02b7ce', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__942e3a', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', 't2__3275ca');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('`', 't2__3275ca');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('F', 't2__3275ca');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) AS atomnums_h FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND T1.element = 'h';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(atom_id) FROM atom WHERE molecule_id IN (SELECT molecule_id FROM molecule WHERE label = '+') AND element = 'H';

/*
Prediction Result:
(0,)
*/