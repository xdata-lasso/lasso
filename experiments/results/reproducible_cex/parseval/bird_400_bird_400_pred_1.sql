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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'set_3a120d', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'a9000t5c4eci');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'Spanish', 'set_3a120d', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Spanish', 'set_3a120d', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Spanish', 'set_3a120d', 'qyp5s5bbp0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'set_af64f7', 'set_3a120d', '2eutliqa11r');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Spanish', 'set_3a120d', 'ytoo3o9hl7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, NULL, 'set_3a120d', 'lex');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'Spanish', 'set_3a120d', 'ji7zwau2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'Spanish', 'set_3a120d', 'yrq13p');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'Spanish', 'set_3a120d', '78d99r');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'Spanish', 'set_3a120d', 'sl0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'Spanish', 'set_3a120d', 'yp5qi2rk');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'Spanish', 'set_3a120d', 'vqx58pz0f');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'Spanish', 'set_3a120d', 'gd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, 'Spanish', 'set_3a120d', 'vy9uxj4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (13, 'Spanish', 'set_3a120d', 'bdvlph');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT setCode FROM set_translations WHERE language = 'Spanish';

/*
Gold Result:
('set_3a120d',)
('set_3a120d',)
('set_3a120d',)
('set_3a120d',)
('set_3a120d',)
('set_3a120d',)
('set_3a120d',)
('set_3a120d',)
('set_3a120d',)
('set_3a120d',)
('set_3a120d',)
('set_3a120d',)
('set_3a120d',)
*/

-- Prediction Query
SELECT DISTINCT setCode FROM set_translations WHERE language = 'Spanish';

/*
Prediction Result:
('set_3a120d',)
*/