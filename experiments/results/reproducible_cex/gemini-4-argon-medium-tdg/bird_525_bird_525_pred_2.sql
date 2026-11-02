-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests NULL handling, case sensitivity, and substring/LIKE mutations.
INSERT INTO "cards" (id, uuid, name) VALUES (1, 'uuid-exact-ban', 'Exact Ban');
INSERT INTO "cards" (id, uuid, name) VALUES (2, 'uuid-case-format', 'Case Format');
INSERT INTO "cards" (id, uuid, name) VALUES (3, 'uuid-case-status', 'Case Status');
INSERT INTO "cards" (id, uuid, name) VALUES (4, 'uuid-substr-format', 'Substr Format');
INSERT INTO "cards" (id, uuid, name) VALUES (5, 'uuid-substr-status', 'Substr Status');
INSERT INTO "cards" (id, uuid, name) VALUES (6, 'uuid-null-status', 'Null Status');
INSERT INTO "cards" (id, uuid, name) VALUES (7, 'uuid-null-format', 'Null Format');
INSERT INTO "legalities" (id, format, status, uuid) VALUES (1, 'oldschool', 'Banned', 'uuid-exact-ban');
INSERT INTO "legalities" (id, format, status, uuid) VALUES (2, 'Oldschool', 'Banned', 'uuid-case-format');
INSERT INTO "legalities" (id, format, status, uuid) VALUES (3, 'oldschool', 'banned', 'uuid-case-status');
INSERT INTO "legalities" (id, format, status, uuid) VALUES (4, 'oldschool_9394', 'Banned', 'uuid-substr-format');
INSERT INTO "legalities" (id, format, status, uuid) VALUES (5, 'oldschool', 'BannedInCommander', 'uuid-substr-status');
INSERT INTO "legalities" (id, format, status, uuid) VALUES (6, 'oldschool', NULL, 'uuid-null-status');
INSERT INTO "legalities" (id, format, status, uuid) VALUES (7, NULL, 'Restricted', 'uuid-null-format');
INSERT INTO "legalities" (id, format, status, uuid) VALUES (8, 'oldschool', 'Restricted', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT uuid FROM legalities WHERE format = 'oldschool' AND (status = 'Banned' OR status = 'Restricted');

/*
Gold Result:
('uuid-exact-ban',)
(None,)
*/

-- Prediction Query
SELECT l.uuid FROM legalities AS l JOIN cards AS c ON l.uuid = c.uuid WHERE l.format = 'oldschool' AND (l.status = 'Banned' OR l.status = 'Restricted');

/*
Prediction Result:
('uuid-exact-ban',)
*/