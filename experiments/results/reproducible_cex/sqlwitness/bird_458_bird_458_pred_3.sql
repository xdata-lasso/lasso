-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cards (id, artist, asciiname, availability, bordercolor, cardkingdomfoilid, cardkingdomid, coloridentity, colorindicator, colors, convertedmanacost, dueldeck, edhrecrank, faceconvertedmanacost, facename, flavorname, flavortext, frameeffects, frameversion, hand, hasalternativedecklimit, hascontentwarning, hasfoil, hasnonfoil, isalternative, isfullart, isonlineonly, isoversized, ispromo, isreprint, isreserved, isstarter, isstoryspotlight, istextless, istimeshifted, keywords, layout, leadershipskills, life, loyalty, manacost, mcmid, mcmmetaid, mtgarenaid, mtgjsonv4id, mtgofoilid, mtgoid, multiverseid, name, number, originalreleasedate, originaltext, originaltype, otherfaceids, power, printings, promotypes, purchaseurls, rarity, scryfallid, scryfallillustrationid, scryfalloracleid, setcode, side, subtypes, supertypes, tcgplayerproductid, text, toughness, type, types, uuid, variations, watermark) VALUES (1, 'default1', 'default1', 'black', 'black', 'black', NULL, 'default2', 'black', '%arena,mtgo%', 2.0, '%arena,mtgo%', NULL, 1.0, NULL, 'black', 'default1', 'default1', 'default2', '%arena,mtgo%', 1, 1, 2, 0, 0, 2, 2, 1, 0, 2, 0, 0, 1, 1, 1, 'default2', 'black', '%arena, mtgo%', 'default2', 'default2', '%arena,mtgo%', 'default2', '%arena,mtgo%', NULL, '%arena,mtgo%', 'black', '%arena, mtgo%', 'black', '%arena, mtgo%', NULL, 'black', '%arena,mtgo%', NULL, 'default2', '%arena, mtgo%', NULL, 'default2', NULL, '%arena,mtgo%', NULL, NULL, 'default2', 'default1', '%arena,mtgo%', 'default1', 'black', 'default1', '%arena,mtgo%', 'default1', NULL, NULL, '%arena,mtgo%', 'default1', NULL), (2, 'black', 'default2', 'default1', 'default1', '%arena,mtgo%', 'black', 'black', 'default1', NULL, 0.0, '%arena, mtgo%', 0, NULL, NULL, 'black', NULL, NULL, 'default1', '%arena,mtgo%', 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 1, 2, 2, 0, 1, 'default2', '%arena,mtgo%', 'default2', '%arena,mtgo%', 'default1', '%arena, mtgo%', '%arena, mtgo%', 'default2', 'black', 'black', 'default1', 'default1', '%arena,mtgo%', '%arena, mtgo%', '%arena,mtgo%', '%arena, mtgo%', NULL, '%arena,mtgo%', 'default1', 'default2', 'default2', '%arena,mtgo%', 'default1', 'default1', NULL, '%arena, mtgo%', '%arena, mtgo%', 'black', 'default2', 'black', '%arena,mtgo%', 'black', NULL, 'default1', 'default2', 'default2', '%arena, mtgo%', '%arena, mtgo%', NULL), (0, 'default1', '%arena, mtgo%', '%arena, mtgo%', 'black', 'default2', NULL, 'default1', 'default1', '%arena, mtgo%', 2.0, 'default2', 1, 0.0, 'black', 'default1', '%arena,mtgo%', '%arena, mtgo%', NULL, NULL, 1, 0, 0, 2, 1, 0, 2, 0, 2, 0, 0, 0, 2, 2, 0, '%arena, mtgo%', '%arena,mtgo%', 'default2', 'black', 'default2', 'black', '%arena,mtgo%', NULL, '%arena, mtgo%', '%arena,mtgo%', 'default1', '%arena, mtgo%', 'default2', NULL, '%arena,mtgo%', 'default1', '%arena, mtgo%', '%arena,mtgo%', 'default2', 'black', NULL, '%arena, mtgo%', NULL, 'default1', 'default1', 'default2', 'default1', NULL, NULL, '%arena,mtgo%', 'black', 'default2', 'default1', '%arena,mtgo%', '%arena,mtgo%', NULL, 'black', 'default1', 'black');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN availability LIKE '%arena,mtgo%' THEN 1 ELSE NULL END) FROM cards;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT artist) FROM cards WHERE availability LIKE '%arena, mtgo%' AND borderColor = 'black';

/*
Prediction Result:
(1,)
*/