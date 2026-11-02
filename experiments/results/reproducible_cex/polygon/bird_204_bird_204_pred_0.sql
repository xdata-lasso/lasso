-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR09910', '+4040571880101561608', '+4040571880101561608');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR0009', '+4040571880101561608', '+4040571880101561608');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('+11', NULL, '+4040571880101561608');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR0009', 'TR0009', '+11');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('+4040571880101561608', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.molecule_id) FROM molecule AS T WHERE molecule_id BETWEEN 'TR000' AND 'TR099' AND T.label = '+';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM molecule WHERE molecule_id BETWEEN 'TR000' AND 'TR099' AND label = '+';

/*
Prediction Result:
(0,)
*/