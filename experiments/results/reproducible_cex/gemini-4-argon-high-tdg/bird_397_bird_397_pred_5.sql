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
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (1, 'uuid-201', 'Exact Match Card', '{2}{U}{U}', 'mtgo,paper', 'black', '2003', 'normal');
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (2, 'uuid-202', 'MTGO Only', '{1}', 'mtgo', 'black', '2003', 'normal');
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (3, 'uuid-203', 'Arena Superset', '{2}', 'arena,mtgo,paper', 'black', '2003', 'normal');
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (4, 'uuid-204', 'Reversed Availability', '{3}', 'paper,mtgo', 'black', '2003', 'normal');
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (5, 'uuid-205', 'Case Mismatch Availability', '{4}', 'MTGO,PAPER', 'black', '2003', 'normal');
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (6, 'uuid-206', 'Frame 1997', '{5}', 'mtgo,paper', 'black', '1997', 'normal');
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (7, 'uuid-207', 'Frame 2002 Off-By-One', '{6}', 'mtgo,paper', 'black', '2002', 'normal');
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (8, 'uuid-208', 'Frame 2004 Off-By-One', '{7}', 'mtgo,paper', 'black', '2004', 'normal');
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (9, 'uuid-209', 'Frame Leading Zero Text Affinity', '{8}', 'mtgo,paper', 'black', '02003', 'normal');
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (10, 'uuid-210', 'Frame Alphanumeric Cast Trap', '{9}', 'mtgo,paper', 'black', '2003a', 'normal');
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (11, 'uuid-211', 'Border Substring Trap', '{10}', 'mtgo,paper', 'black_border', '2003', 'normal');
INSERT INTO cards (id, uuid, name, manaCost, availability, borderColor, frameVersion, layout) VALUES (12, 'uuid-212', 'Layout Substring Trap', '{11}', 'mtgo,paper', 'black', '2003', 'normal_card');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT manaCost FROM cards WHERE availability = 'mtgo,paper' AND borderColor = 'black' AND frameVersion = 2003 AND layout = 'normal';

/*
Gold Result:
('{2}{U}{U}',)
*/

-- Prediction Query
SELECT manacost FROM cards WHERE layout = 'normal' AND frameversion = '2003' AND bordercolor = 'black' AND availability LIKE '%mtgo,paper%';

/*
Prediction Result:
('{2}{U}{U}',)
('{2}',)
('{4}',)
*/