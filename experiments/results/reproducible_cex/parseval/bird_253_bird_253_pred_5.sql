-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__a1a312', 'molecule_i_1', 't3__1d392a');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', 't3__1d392a');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'molecule_i_1', 'posiie5unw6k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'molecule_i_1', '52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'molecule_i_1', '4nrq');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'molecule_i_1', 't3__1d392a');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'molecule_i_1', 's5bbp02e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'molecule_i_1', 't3__1d392a');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'molecule_i_1', '1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'ytoo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'x1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', 'dwyrq13pyu78');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 't3__1d392a');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'b4yp5qi');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'f8jegd21vy9u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__2f94db', 'molecule_i_1', 'h2gn');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__9dc90d', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__070f14', 'molecule_i_1', '#');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a1a312', 't2__a1a312', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't2__a1a312', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'C', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'C', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_5', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_5', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_6', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_7', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_8', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 'atom_id_5', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_10', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_12', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_13', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a1a312', 'atom_id_13', 't2__070f14');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_14', 't2__070f14');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_10', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '_', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a1a312', 'atom_id_6', 't2__070f14');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_15', 't2__070f14');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_5', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_17', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a1a312', 'O', 't2__070f14');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'I', 't2__070f14');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 'atom_id_8', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_18', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a1a312', 'A', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_19', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a1a312', 'C', '@');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__a1a312', 'atom_id_12', 't1__9dc90d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'G', 't1__9dc90d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('t3__1d392a',)
('gu7v',)
('luhvdltti',)
*/

-- Prediction Query
SELECT DISTINCT a1.element, a2.element FROM bond AS b INNER JOIN connected AS c ON b.bond_id = c.bond_id INNER JOIN atom AS a1 ON c.atom_id = a1.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE b.bond_type = '#';

/*
Prediction Result:
('t3__1d392a', 't3__1d392a')
('gu7v', 't3__1d392a')
('luhvdltti', 't3__1d392a')
('luhvdltti', 'posiie5unw6k')
('luhvdltti', '52zb')
('luhvdltti', '4nrq')
('luhvdltti', '1')
('luhvdltti', 'ytoo3o9')
('t3__1d392a', 'ytoo3o9')
('luhvdltti', 'x1')
('t3__1d392a', 's5bbp02e')
('t3__1d392a', '00t5c4ecigc')
('luhvdltti', 'dwyrq13pyu78')
('t3__1d392a', 'posiie5unw6k')
('luhvdltti', 'b4yp5qi')
('t3__1d392a', '4nrq')
('luhvdltti', 'f8jegd21vy9u')
('t3__1d392a', 'luhvdltti')
('luhvdltti', 'v')
('t3__1d392a', '1')
*/