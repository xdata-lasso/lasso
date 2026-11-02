-- Schema DDL
/* Relational schema for MMRO-BM (ManyMutationsRandomObfuscated: Random Letter Strings) */ /* Relational schema for ManyMutantsBM benchmark suite. */ /* Universal schema compatible with SQLite, PostgreSQL, and MySQL. */ CREATE TABLE udaxih (utlsgw INTEGER PRIMARY KEY, cbvhyj TEXT(100) NOT NULL UNIQUE, chdmio TEXT(100) NOT NULL);

CREATE TABLE hexdvx (ulfllg INTEGER PRIMARY KEY, viwvuc TEXT(100) NOT NULL, utlsgw INTEGER NOT NULL, tufrxh TEXT(50) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE rcsnba (rhvkyy INTEGER PRIMARY KEY, bhbzkm TEXT(100) NOT NULL UNIQUE, utlsgw INTEGER NOT NULL, icgswk REAL NOT NULL, gupmuo TEXT(20) NOT NULL, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE cghqta (eiehxr INTEGER PRIMARY KEY, ulfllg INTEGER NOT NULL, rhvkyy INTEGER NOT NULL, rixsns TEXT(20) NOT NULL, mlheqp REAL NOT NULL, UNIQUE (ulfllg, rhvkyy), FOREIGN KEY (ulfllg) REFERENCES hexdvx (ulfllg), FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy));

CREATE TABLE rgwuwr (cybdeu INTEGER PRIMARY KEY, rhvkyy INTEGER NOT NULL, fzvntc INTEGER, tufrxh TEXT(200) NOT NULL, mmtoqi TEXT(20) NOT NULL, gupmuo TEXT(20) NOT NULL, ravxdv TEXT(20) NOT NULL, FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy), FOREIGN KEY (fzvntc) REFERENCES hexdvx (ulfllg));

CREATE TABLE nhosiz (ryiyuk INTEGER PRIMARY KEY, djnfoa TEXT(100) NOT NULL, xxiqyf TEXT(20) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1);

CREATE TABLE ayzfwn (qdujuq INTEGER PRIMARY KEY, ryiyuk INTEGER NOT NULL, tgelyf TEXT(20) NOT NULL, ryqatk TEXT(20) NOT NULL, padlzj TEXT(20) NOT NULL DEFAULT 'STANDARD', hbhscc REAL NOT NULL DEFAULT 0, FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

CREATE TABLE kiegyk (xpcyry INTEGER PRIMARY KEY, eevprf TEXT(100) NOT NULL UNIQUE, iqtngr TEXT(50) NOT NULL);

CREATE TABLE dcmdll (yxwgwj INTEGER PRIMARY KEY, xpcyry INTEGER NOT NULL, mvuloq TEXT(100) NOT NULL, odhhck REAL NOT NULL, asrhsh INTEGER NOT NULL DEFAULT 0, FOREIGN KEY (xpcyry) REFERENCES kiegyk (xpcyry));

CREATE TABLE tizbxo (acwubh INTEGER PRIMARY KEY, qdujuq INTEGER NOT NULL, yxwgwj INTEGER NOT NULL, cbkcqh INTEGER NOT NULL, ivpgre REAL NOT NULL, xssphz REAL, UNIQUE (qdujuq, yxwgwj), FOREIGN KEY (qdujuq) REFERENCES ayzfwn (qdujuq), FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj));

CREATE TABLE rdmcrj (pzngdd INTEGER PRIMARY KEY, yxwgwj INTEGER NOT NULL, ryiyuk INTEGER NOT NULL, vnlnno INTEGER NOT NULL, xbvuud INTEGER NOT NULL DEFAULT 0, bmxkzd TEXT(20) NOT NULL, FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj), FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO kiegyk (xpcyry, eevprf, iqtngr) VALUES (1, 'CatA', 'DescA');
INSERT INTO kiegyk (xpcyry, eevprf, iqtngr) VALUES (2, 'CatB', 'DescB');
INSERT INTO dcmdll (yxwgwj, xpcyry, mvuloq, odhhck, asrhsh) VALUES (10, 1, 'Item1', 100.0, 0);
INSERT INTO dcmdll (yxwgwj, xpcyry, mvuloq, odhhck, asrhsh) VALUES (20, 1, 'Item2', 200.0, 0);
INSERT INTO dcmdll (yxwgwj, xpcyry, mvuloq, odhhck, asrhsh) VALUES (30, 1, 'Item3', 150.0, 0);
INSERT INTO dcmdll (yxwgwj, xpcyry, mvuloq, odhhck, asrhsh) VALUES (40, 2, 'Item4', 50.0, 0);
INSERT INTO dcmdll (yxwgwj, xpcyry, mvuloq, odhhck, asrhsh) VALUES (50, 2, 'Item5', 300.0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT yxwgwj, mvuloq, xpcyry, odhhck FROM (SELECT p.yxwgwj, p.mvuloq, p.xpcyry, p.odhhck, ROW_NUMBER() OVER (PARTITION BY p.xpcyry ORDER BY p.odhhck DESC, p.yxwgwj ASC) AS rank_in_cat FROM dcmdll AS p WHERE p.asrhsh = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Gold Result:
(20, 'Item2', 1, 200.0)
(50, 'Item5', 2, 300.0)
*/

-- Prediction Query
SELECT yxwgwj, mvuloq, xpcyry, odhhck FROM (SELECT p.yxwgwj, p.mvuloq, p.xpcyry, p.odhhck, ROW_NUMBER() OVER (ORDER BY p.odhhck DESC, p.yxwgwj ASC) AS rank_in_cat FROM dcmdll AS p WHERE p.asrhsh = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Prediction Result:
(50, 'Item5', 2, 300.0)
*/