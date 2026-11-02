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
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-1', 'mtgo', 'black', '2003', 'normal', '{W}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-2', 'paper,mtgo', 'black', '2003', 'normal', '{U}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-3', 'arena,mtgo,paper', 'black', '2003', 'normal', '{B}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-4', NULL, 'black', '2003', 'normal', '{R}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-5', 'mtgo,paper', 'borderless', '2003', 'normal', '{G}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-6', 'mtgo,paper', 'silver', '2003', 'normal', '{1}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-7', 'mtgo,paper', NULL, '2003', 'normal', '{2}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-8', 'mtgo,paper', 'black', '2002', 'normal', '{3}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-9', 'mtgo,paper', 'black', '2004', 'normal', '{4}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-10', 'mtgo,paper', 'black', 'future', 'normal', '{5}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-11', 'mtgo,paper', 'black', NULL, 'normal', '{6}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-12', 'mtgo,paper', 'black', '2003', 'transform', '{7}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-13', 'mtgo,paper', 'black', '2003', 'normal_extra', '{8}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-14', 'mtgo,paper', 'black', '2003', NULL, '{9}');
INSERT INTO "cards" (uuid, availability, borderColor, frameVersion, layout, manaCost) VALUES ('u2-valid', 'mtgo,paper', 'black', '2003', 'normal', '{X}{R}');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT manaCost FROM cards WHERE availability = 'mtgo,paper' AND borderColor = 'black' AND frameVersion = 2003 AND layout = 'normal';

/*
Gold Result:
('{X}{R}',)
*/

-- Prediction Query
SELECT manacost FROM cards WHERE layout = 'normal' AND frameversion = '2003' AND bordercolor = 'black' AND availability LIKE '%mtgo,paper%';

/*
Prediction Result:
('{B}',)
('{X}{R}',)
*/