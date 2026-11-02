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
-- Tests DISTINCT behavior (duplicate card names within the same set and across multiple translations),
-- WHERE clause filtering (exact match vs partial match vs wrong translation),
-- and INNER JOIN vs OUTER JOIN (cards with no set_translations or NULL setCode).
INSERT INTO sets (id, code, name) VALUES (1, '10E', 'Tenth Edition');
INSERT INTO sets (id, code, name) VALUES (2, '9ED', 'Ninth Edition');
INSERT INTO sets (id, code, name) VALUES (3, '8ED', 'Eighth Edition');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'German', '10E', 'Hauptset Zehnte Edition');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (2, 'Custom', '10E', 'Hauptset Zehnte Edition');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (3, 'French', '10E', 'Dixième édition');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (4, 'German', '9ED', 'Hauptset Zehnte Edition Extra');
INSERT INTO cards (id, name, asciiName, faceName, setCode, uuid) VALUES (1, 'Grizzly Bears', 'Grizzly Bears_ascii', 'Grizzly Bears_face', '10E', 'uuid-1');
INSERT INTO cards (id, name, asciiName, faceName, setCode, uuid) VALUES (2, 'Grizzly Bears', 'Grizzly Bears_ascii', 'Grizzly Bears_face', '10E', 'uuid-2');
INSERT INTO cards (id, name, asciiName, faceName, setCode, uuid) VALUES (3, 'Shock', 'Shock_ascii', 'Shock_face', '9ED', 'uuid-3');
INSERT INTO cards (id, name, asciiName, faceName, setCode, uuid) VALUES (4, 'Pacifism', 'Pacifism_ascii', 'Pacifism_face', '8ED', 'uuid-4');
INSERT INTO cards (id, name, asciiName, faceName, setCode, uuid) VALUES (5, 'Orphan Card', 'Orphan_ascii', 'Orphan_face', NULL, 'uuid-5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM cards AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.setCode WHERE T2.translation = 'Hauptset Zehnte Edition';

/*
Gold Result:
('Grizzly Bears',)
*/

-- Prediction Query
SELECT cards.name FROM set_translations INNER JOIN cards ON set_translations.setCode = cards.setCode WHERE set_translations.translation = 'Hauptset Zehnte Edition';

/*
Prediction Result:
('Grizzly Bears',)
('Grizzly Bears',)
('Grizzly Bears',)
('Grizzly Bears',)
*/