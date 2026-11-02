-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "cards" ("id", "name", "asciiName", "faceName", "flavorName", "uuid") VALUES (1, 'Benalish Knight', 'Different Ascii', 'Different Face', 'Different Flavor', 'uuid-bk-1');
INSERT INTO "cards" ("id", "name", "asciiName", "faceName", "flavorName", "uuid") VALUES (2, 'Benalish Knight', 'Benalish Knight', 'Benalish Knight', 'Benalish Knight', 'uuid-bk-2');
INSERT INTO "cards" ("id", "name", "asciiName", "faceName", "flavorName", "uuid") VALUES (3, 'Other Card', 'Benalish Knight', 'Benalish Knight', 'Benalish Knight', 'uuid-other-1');
INSERT INTO "cards" ("id", "name", "asciiName", "faceName", "flavorName", "uuid") VALUES (4, 'Benalish Knight Veteran', 'Other', 'Other', 'Other', 'uuid-super-1');
INSERT INTO "cards" ("id", "name", "asciiName", "faceName", "flavorName", "uuid") VALUES (5, 'benalish knight', 'Other', 'Other', 'Other', 'uuid-case-1');
INSERT INTO "cards" ("id", "name", "asciiName", "faceName", "flavorName", "uuid") VALUES (6, NULL, 'Other', 'Other', 'Other', 'uuid-null-1');
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (10, 'commander', 'Legal', 'uuid-bk-1');
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (11, 'modern', 'Banned', 'uuid-bk-1');
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (12, 'commander', 'Restricted', 'uuid-bk-2');
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (13, 'legacy', NULL, 'uuid-bk-2');
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (14, 'vintage', 'Legal', 'uuid-other-1');
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (15, 'standard', 'Legal', 'uuid-super-1');
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (16, 'pauper', 'Legal', 'uuid-case-1');
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (17, 'historic', 'Legal', 'uuid-null-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.format FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T1.name = 'Benalish Knight';

/*
Gold Result:
('commander',)
('modern',)
('commander',)
('legacy',)
*/

-- Prediction Query
SELECT DISTINCT T2.format FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T1.name = 'Benalish Knight';

/*
Prediction Result:
('commander',)
('modern',)
('legacy',)
*/