-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO cards (id, uuid, name, artist, availability, isOnlineOnly) VALUES (201, 'uuid-201', 'Exact Match Card', 'Erica Yang', 'paper', 1);
INSERT INTO cards (id, uuid, name, artist, availability, isOnlineOnly) VALUES (202, 'uuid-202', 'Multi Avail Trap', 'Erica Yang', 'mtgo, paper', 0);
INSERT INTO cards (id, uuid, name, artist, availability, isOnlineOnly) VALUES (203, 'uuid-203', 'Partial Artist Trap', 'Erica Yang & Greg Staples', 'paper', 0);
INSERT INTO cards (id, uuid, name, artist, availability, isOnlineOnly) VALUES (204, 'uuid-204', 'Lower Artist Trap', 'erica yang', 'paper', 0);
INSERT INTO cards (id, uuid, name, artist, availability, isOnlineOnly) VALUES (205, 'uuid-205', 'Upper Avail Trap', 'Erica Yang', 'Paper', 0);
INSERT INTO cards (id, uuid, name, artist, availability, isOnlineOnly) VALUES (206, 'uuid-206', 'Upper Format Trap', 'Erica Yang', 'paper', 0);
INSERT INTO legalities (id, uuid, format, status) VALUES (1, 'uuid-201', 'pauper', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (2, 'uuid-202', 'pauper', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (3, 'uuid-203', 'pauper', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (4, 'uuid-204', 'pauper', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (5, 'uuid-205', 'pauper', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (6, 'uuid-206', 'Pauper', 'Legal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.id FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T1.artist = 'Erica Yang' AND T2.format = 'pauper' AND T1.availability = 'paper';

/*
Gold Result:
(201,)
*/

-- Prediction Query
SELECT "cards"."id" FROM "cards" INNER JOIN "legalities" ON "cards"."uuid" = "legalities"."uuid" WHERE "cards"."artist" = 'Erica Yang' AND "legalities"."format" = 'pauper' AND "cards"."availability" LIKE '%paper%';

/*
Prediction Result:
(201,)
(202,)
(205,)
*/