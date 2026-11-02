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
-- Comprehensive dataset testing:
-- 1. DISTINCT on translation (duplicate translations within the same set and across different sets).
-- 2. INNER JOIN vs IN subquery (multiple 'Angel of Mercy' cards in the same set).
-- 3. Card name filtering (exact match vs partial match, case sensitivity, other cards, NULL names).
-- 4. SetCode matching (sets with no 'Angel of Mercy' cards).
-- 5. NULL handling on translation and setCode.
-- 6. Wrong column counting (COUNT(language) or COUNT(setCode) vs COUNT(DISTINCT translation)).
INSERT INTO "sets" ("id", "code", "name") VALUES (1, 'S1', 'Set One');
INSERT INTO "sets" ("id", "code", "name") VALUES (2, 'S2', 'Set Two');
INSERT INTO "sets" ("id", "code", "name") VALUES (3, 'S3', 'Set Three');
INSERT INTO "sets" ("id", "code", "name") VALUES (4, 'S4', 'Set Four');
-- S1 has two 'Angel of Mercy' cards (e.g., normal and foil/alt art) -> tests JOIN multiplicity vs IN
INSERT INTO "cards" ("id", "uuid", "name", "setCode") VALUES (1, 'u1', 'Angel of Mercy', 'S1');
INSERT INTO "cards" ("id", "uuid", "name", "setCode") VALUES (2, 'u2', 'Angel of Mercy', 'S1');
-- S2 has one 'Angel of Mercy' card
INSERT INTO "cards" ("id", "uuid", "name", "setCode") VALUES (3, 'u3', 'Angel of Mercy', 'S2');
-- S3 has cards with similar names or different names, but NOT 'Angel of Mercy'
INSERT INTO "cards" ("id", "uuid", "name", "setCode") VALUES (4, 'u4', 'Angel of Mercy ', 'S3');
INSERT INTO "cards" ("id", "uuid", "name", "setCode") VALUES (5, 'u5', 'angel of mercy', 'S3');
INSERT INTO "cards" ("id", "uuid", "name", "setCode") VALUES (6, 'u6', 'Archangel of Mercy', 'S3');
INSERT INTO "cards" ("id", "uuid", "name", "setCode") VALUES (7, 'u7', 'Serra Angel', 'S3');
INSERT INTO "cards" ("id", "uuid", "name", "setCode") VALUES (8, 'u8', NULL, 'S3');
-- Card with 'Angel of Mercy' but NULL setCode
INSERT INTO "cards" ("id", "uuid", "name", "setCode") VALUES (9, 'u9', 'Angel of Mercy', NULL);
-- Translations for S1:
-- 'Trans_A' is duplicated across two languages in S1 (tests DISTINCT translation vs DISTINCT language/id)
-- Also includes a NULL translation (tests NOT translation IS NULL vs COUNT(*))
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (1, 'French', 'S1', 'Trans_A');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (2, 'Canadian French', 'S1', 'Trans_A');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (3, 'German', 'S1', 'Trans_B');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (4, 'Spanish', 'S1', NULL);
-- Translations for S2:
-- 'Trans_B' is shared with S1 (tests cross-set DISTINCT translation)
-- 'Trans_C' is unique to S2
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (5, 'German', 'S2', 'Trans_B');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (6, 'Italian', 'S2', 'Trans_C');
-- Translations for S3 (should be excluded because S3 has no exact 'Angel of Mercy'):
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (7, 'French', 'S3', 'Trans_D');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (8, 'German', 'S3', 'Trans_E');
-- Translations for S4 (no cards in S4 at all):
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (9, 'Japanese', 'S4', 'Trans_F');
-- Translation with NULL setCode:
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (10, 'Russian', NULL, 'Trans_G');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT translation) FROM set_translations WHERE setCode IN (SELECT setCode FROM cards WHERE name = 'Angel of Mercy') AND NOT translation IS NULL;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.language) FROM set_translations AS T1 INNER JOIN cards AS T2 ON T1.setCode = T2.setCode WHERE T2.name = 'Angel of Mercy';

/*
Prediction Result:
(5,)
*/