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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__f8979b', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2007-07-13', -45536098, 1861536320, '6klfa9');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 283598170, 'zbuo4nrq', 'rofqyp5s5b', 't2__d2d571', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274769912, 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '2007-07-13', -1021749117, 392822403, 'yu78');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 244829661, 'jsl', 'b4yp5qi', 'code_2', -227162283, 2056419640, 222415430, 556727997, 1178000634, 'pz0f8jegd', -283454505, 233994589, 'j4hwbd', 'lph2gn', 'q', 'nqcx5h', '2007-07-13', -1245312912, 1575412235, 'jtu0d');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, 1784916884, 'ah0f8jsww', 'q7x', 'A', -541746689, 1294666887, -515895469, 1427161052, 564390026, '6nijjai5dh', 1583472758, 1449284300, 'gjd8y', 't1afgog', 'itsj3', 'y', '2007-07-13', -598313376, 1972233925, '4301j');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 1948383687, 'e', '8c68', 'G', -683007527, 2035306060, 1523825314, 2078438287, -47052816, '1of77pzo72c', -820614248, 481546706, 'g6', 'g0v5q8qd', 'jpe1io22785', '7cvtjpt', '2023-05-24', 1467355421, -1171104889, '5zi36c4bfkfo');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -405743609, 'g', '5i3', '_', -1405314653, 1816660482, -1212676731, 1692046802, -1300180872, '58q', 1817366143, 1615073310, '7p2r94gth2m', 'ajjl', '3', 'okv8uttmu2', '2022-05-03', -1817527403, -1402164108, 'yz7zzb');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, '00t5c4e', 't1__f8979b', 'cigce376nium');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, '79fjgq8', 't2__d2d571', 'n2f3dqv0gcb9');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'ozk3zbily', 't2__d2d571', 'kn6vc');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'c', 'G', '0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, '7z2zezjo7wg', 'G', 'd5ysxc');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, '8y', '_', 'kv42q7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 'x58b4', 't1__f8979b', 'pmaus3auvmkr');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 'pdjwzw5chn9', 't1__f8979b', 'o705');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '5k5swwqcgs', 't1__f8979b', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '4', 't1__f8979b', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'e4', 't1__f8979b', 'hria2ypuzhs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'rwbbp6luhvd', 't1__f8979b', 'tti');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'bnp', 't1__f8979b', 'mdpos');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'ie5', 't1__f8979b', 'nw6klf');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'a9000t5c4eci', 't1__f8979b', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'zbuo4nrqrof', 't1__f8979b', 'qyp5s5bbp0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, '2eutliqa11r', 't1__f8979b', 'ytoo3o9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.setCode FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.releaseDate = '2007-07-13';

/*
Gold Result:
('t1__f8979b',)
('t1__f8979b',)
('t1__f8979b',)
('t2__d2d571',)
('t2__d2d571',)
('t1__f8979b',)
('t1__f8979b',)
('t1__f8979b',)
('t1__f8979b',)
('t1__f8979b',)
('t1__f8979b',)
('t1__f8979b',)
('t1__f8979b',)
('t1__f8979b',)
*/

-- Prediction Query
SELECT code FROM sets WHERE releaseDate = '2007-07-13';

/*
Prediction Result:
('t1__f8979b',)
('t2__d2d571',)
('code_2',)
('A',)
*/