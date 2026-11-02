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
INSERT INTO kiegyk (xpcyry, eevprf, iqtngr) VALUES (-1, 'default2', 'default2'), (1, 'default1', 'default1'), (2, 'unique_2', 'default2'), (0, 'unique_3', 'default2'), (3, 'unique_4', 'default1'), (4, 'unique_5', 'default1'), (5, 'unique_6', 'default1'), (6, 'unique_7', 'default1'), (7, 'unique_8', 'default2'), (8, 'unique_9', 'default2'), (9, 'unique_10', 'default1'), (10, 'unique_11', 'default1'), (11, 'unique_12', 'default2'), (12, 'unique_13', 'default1'), (13, 'unique_14', 'default2'), (14, 'unique_15', 'default2'), (15, 'unique_16', 'default1'), (16, 'unique_17', 'default2'), (17, 'unique_18', 'default1'), (18, 'unique_19', 'default2');
INSERT INTO dcmdll (yxwgwj, xpcyry, mvuloq, odhhck, asrhsh) VALUES (-1, 15, 'default2', -1.0, 0), (2, 17, 'default1', 0.0, 0), (1, -1, 'default1', -1.0, -1), (0, 18, 'default1', 0.0, 2), (3, 8, 'default1', 1.0, 1), (4, 11, 'default1', 1.0, 1), (5, 15, 'default1', 0.0, 0), (6, 7, 'default1', -1.0, -1), (7, 4, 'default1', 1.0, 1), (8, 15, 'default2', 2.0, 2), (9, 4, 'default2', 0.0, 1), (10, 18, 'default2', 0.0, 0), (11, 4, 'default2', -1.0, 0), (12, 12, 'default2', 0.0, 1), (13, 2, 'default2', -1.0, 2), (14, 0, 'default2', 2.0, -1), (15, 10, 'default1', 1.0, 1), (16, 0, 'default1', 2.0, 0), (17, 4, 'default1', 2.0, 0), (18, 0, 'default2', 0.0, -1), (19, 17, 'default1', 2.0, -1), (20, 4, 'default1', 2.0, 0), (21, 2, 'default1', 1.0, 1), (22, 8, 'default2', 1.0, 2), (23, 10, 'default1', -1.0, -1), (24, 12, 'default1', -1.0, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT yxwgwj, mvuloq, xpcyry, odhhck FROM (SELECT p.yxwgwj, p.mvuloq, p.xpcyry, p.odhhck, ROW_NUMBER() OVER (PARTITION BY p.xpcyry ORDER BY p.odhhck DESC, p.yxwgwj ASC) AS rank_in_cat FROM dcmdll AS p WHERE p.asrhsh = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Gold Result:
(16, 'default1', 0, 2.0)
(17, 'default1', 4, 2.0)
(5, 'default1', 15, 0.0)
(2, 'default1', 17, 0.0)
(10, 'default2', 18, 0.0)
*/

-- Prediction Query
SELECT yxwgwj, mvuloq, xpcyry, odhhck FROM (SELECT p.yxwgwj, p.mvuloq, p.xpcyry, p.odhhck, DENSE_RANK() OVER (PARTITION BY p.xpcyry ORDER BY p.odhhck DESC) AS rank_in_cat FROM dcmdll AS p WHERE p.asrhsh = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Prediction Result:
(16, 'default1', 0, 2.0)
(17, 'default1', 4, 2.0)
(20, 'default1', 4, 2.0)
(5, 'default1', 15, 0.0)
(2, 'default1', 17, 0.0)
(10, 'default2', 18, 0.0)
*/