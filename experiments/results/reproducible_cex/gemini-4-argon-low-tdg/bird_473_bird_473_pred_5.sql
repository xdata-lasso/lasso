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
-- Tests basic positive and negative branches of IIF(isForeignOnly = 1, 'YES', 'NO'), duplicate output rows (to kill DISTINCT mutants), and non-matching card names.
INSERT INTO "sets" (id, code, isForeignOnly, isFoilOnly, isNonFoilOnly, isOnlineOnly, isPartialPreview, name) VALUES (1, 'CSP', 0, 1, 1, 1, 1, 'Coldsnap');
INSERT INTO "sets" (id, code, isForeignOnly, isFoilOnly, isNonFoilOnly, isOnlineOnly, isPartialPreview, name) VALUES (2, 'FBB', 1, 0, 0, 0, 0, 'Foreign Black Border');
INSERT INTO "sets" (id, code, isForeignOnly, isFoilOnly, isNonFoilOnly, isOnlineOnly, isPartialPreview, name) VALUES (3, 'OTH', 1, 0, 0, 0, 0, 'Other Set');
INSERT INTO "cards" (id, uuid, name, setCode) VALUES (1, 'uuid-1', 'Adarkar Valkyrie', 'CSP');
INSERT INTO "cards" (id, uuid, name, setCode) VALUES (2, 'uuid-2', 'Adarkar Valkyrie', 'CSP');
INSERT INTO "cards" (id, uuid, name, setCode) VALUES (3, 'uuid-3', 'Adarkar Valkyrie', 'FBB');
INSERT INTO "cards" (id, uuid, name, setCode) VALUES (4, 'uuid-4', 'Black Lotus', 'FBB');
INSERT INTO "cards" (id, uuid, name, setCode) VALUES (5, 'uuid-5', 'Adarkar Valkyrie Promo', 'OTH');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT IIF(isForeignOnly = 1, 'YES', 'NO') FROM cards AS T1 INNER JOIN sets AS T2 ON T2.code = T1.setCode WHERE T1.name = 'Adarkar Valkyrie';

/*
Gold Result:
('NO',)
('NO',)
('YES',)
*/

-- Prediction Query
SELECT EXISTS(SELECT 1 FROM sets WHERE name = 'Adarkar Valkyrie' AND isforeignonly = 1) AS isforeignonlyonlyoutsideus;

/*
Prediction Result:
(0,)
*/