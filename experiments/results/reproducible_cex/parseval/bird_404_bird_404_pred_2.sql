-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, 309, '5k5swwqcgs', '9n8', 't1__6245f5', 1610062532, -106629402, 1871297066, 809183447, 89267185, 'e4', 1160656988, -992890117, 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 309, 'gce', '76nium52', 't1__1baa18', -443340271, 757448742, -1179823637, 1119186446, 781505063, 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '2025-11-18', -453362185, 481163439, '2dwyrq');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 309, 'p5qi2rk', '9v', 'G', 556727997, 1178000634, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw', -2050247126, -736979194, 'h2gn', 'q', 'nqcx5h', 'cprj', '2023-05-30', -792947627, -1898531797, '9fjgq8n2f');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1056308489, 'gcb98oz', '3zb', 'A', -1554531873, 982314585, 638024588, -688098735, 1784916884, 'ah0f8jsww', -1388029300, -566887085, '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '2020-08-13', 1074760385, 1129658414, '1afgo');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 309, '01jh3den', 'c68x8vacx', 'O', -1762140823, 1371234901, -290314193, 76996700, -435350511, '72ctdctmfg62', -1744557630, 1870300798, 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', '2025-09-22', 1944978593, 1722106924, 'f');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, 309, 'cd07z2zezjo7', 'wgxd5ysxcm', 't2__fb7332', 1721638020, 983324983, 1269522000, 853709925, -870767087, 'j5', -1609653472, -1405314653, '5lnpim5k58qs', '7p2r94gt', '2m', 'ajjl', '2020-02-18', 1919033056, -1428186898, 'uttmu2ne5');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 't2__9e7faa', 't1__6245f5', '9000t5c4ec');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 't2__9e7faa', 't1__6245f5', '3pyu78d');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 't2__9e7faa', 't1__6245f5', '9rljsl0b4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 't2__9e7faa', 'A', 'ri');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 't2__9e7faa', 'A', 'tsj3ayxp1q4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 't2__9e7faa', 'A', 'foa');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 't2__9e7faa', 't1__6245f5', '78lfvyz7zz');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, NULL, 't1__6245f5', 'be8yvkv42q7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '5k5swwqcgs', 't1__6245f5', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '4', 't1__6245f5', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'e4', 't1__6245f5', 'hria2ypuzhs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'rwbbp6luhvd', 't1__6245f5', 'tti');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'bnp', 't1__6245f5', 'mdpos');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'ie5', 't1__6245f5', 'nw6klf');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'a9000t5c4eci', 't1__6245f5', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'zbuo4nrqrof', 't1__6245f5', 'qyp5s5bbp0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, '2eutliqa11r', 't1__6245f5', 'ytoo3o9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.baseSetSize = 309;

/*
Gold Result:
('t2__9e7faa',)
('t2__9e7faa',)
(None,)
('t2__9e7faa',)
('t2__9e7faa',)
('5k5swwqcgs',)
('4',)
('e4',)
('rwbbp6luhvd',)
('bnp',)
('ie5',)
('a9000t5c4eci',)
('zbuo4nrqrof',)
('2eutliqa11r',)
*/

-- Prediction Query
SELECT T2.translation FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.baseSetSize = 309;

/*
Prediction Result:
('9000t5c4ec',)
('78lfvyz7zz',)
('be8yvkv42q7',)
('3pyu78d',)
('9rljsl0b4',)
('9n8',)
('gu7v',)
('hria2ypuzhs',)
('tti',)
('mdpos',)
('nw6klf',)
('gce376nium52',)
('qyp5s5bbp0',)
('ytoo3o9',)
*/