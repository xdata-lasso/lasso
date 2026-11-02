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
-- Tests:
-- 1. DISTINCT keyword elimination (multiple rows with identical keywords for 'Angel of Mercy').
-- 2. Handling of multiple distinct keywords for 'Angel of Mercy' (tests against LIMIT 1 or MAX/MIN aggregations).
-- 3. Handling of NULL keywords for 'Angel of Mercy' (tests against WHERE keywords IS NOT NULL).
-- 4. Exact string matching on `name`: case sensitivity ('angel of mercy'), substring/prefix/suffix ('Angel of Mercy II', 'Archangel of Mercy', 'Angel'), and NULL names.
-- 5. Confounding columns: `asciiName`, `faceName`, `flavorName`, `originalText`, `text`, `type`, `subtypes` containing 'Angel of Mercy' or 'Flying' to catch wrong column projections or predicates.
-- 6. Confounding tables: `foreign_data`, `legalities`, `rulings`, `sets` with 'Angel of Mercy' or missing foreign keys (tests against unnecessary INNER JOINs).
INSERT INTO sets (id, code, name) VALUES (1, 'INV', 'Invasion');
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, keywords, text, originalText, type, subtypes, setCode) VALUES
(1, 'uuid-1', 'Angel of Mercy', 'Other Ascii', 'Other Face', 'Other Flavor', 'Flying', 'When Angel of Mercy enters the battlefield, you gain 3 life.', 'Original Text 1', 'Creature — Angel', 'Angel', 'INV'),
(2, 'uuid-2', 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'Flying', 'Diff text', 'Diff orig', 'Creature', 'Angel', NULL),
(3, 'uuid-3', 'Angel of Mercy', 'Ascii 3', 'Face 3', 'Flavor 3', 'Flying, Vigilance', 'Text 3', 'Orig 3', 'Creature', 'Angel', 'INV'),
(4, 'uuid-4', 'Angel of Mercy', 'Ascii 4', 'Face 4', 'Flavor 4', NULL, 'Text 4', 'Orig 4', 'Creature', 'Angel', NULL),
(5, 'uuid-5', 'angel of mercy', 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'Haste', 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'INV'),
(6, 'uuid-6', 'Angel of Mercy II', 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'Trample', 'Text 6', 'Orig 6', 'Creature', 'Angel', 'INV'),
(7, 'uuid-7', 'Archangel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'Lifelink', 'Text 7', 'Orig 7', 'Creature', 'Angel', 'INV'),
(8, 'uuid-8', 'Angel', 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'Deathtouch', 'Text 8', 'Orig 8', 'Creature', 'Angel', 'INV'),
(9, 'uuid-9', NULL, 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'Reach', 'Text 9', 'Orig 9', 'Creature', 'Angel', 'INV');
INSERT INTO foreign_data (id, uuid, name, language, text) VALUES
(1, 'uuid-5', 'Angel of Mercy', 'English', 'Flying');
INSERT INTO legalities (id, uuid, format, status) VALUES
(1, 'uuid-1', 'Commander', 'Legal');
INSERT INTO rulings (id, uuid, date, text) VALUES
(1, 'uuid-1', '2004-10-04', 'Ruling text');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT keywords FROM cards WHERE name = 'Angel of Mercy';

/*
Gold Result:
('Flying',)
('Flying, Vigilance',)
(None,)
*/

-- Prediction Query
SELECT keywords FROM cards WHERE name = 'Angel of Mercy';

/*
Prediction Result:
('Flying',)
('Flying',)
('Flying, Vigilance',)
(None,)
*/