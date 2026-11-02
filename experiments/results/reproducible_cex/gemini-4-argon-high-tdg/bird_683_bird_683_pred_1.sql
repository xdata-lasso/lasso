-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (1, 1000, '2009-01-01 00:00:00', 'UserRep1000');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (2, 1001, '2009-01-01 00:00:00', 'UserRep1001');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (3, 2000, '2009-01-01 00:00:00', 'UserRep2000');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (4, 999, '2009-01-01 00:00:00', 'UserRep999');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, OwnerUserId) VALUES (1, 1, '2011-06-15 12:00:00', 1, 1);
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, OwnerUserId) VALUES (2, 1, '2011-01-01 00:00:00', 1, 2);
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, OwnerUserId) VALUES (3, 1, '2010-12-31 23:59:59', 1, 3);
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, OwnerUserId) VALUES (4, 1, '2011-12-31 23:59:59', 1, 3);
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, OwnerUserId) VALUES (5, 1, '2012-01-01 00:00:00', 1, 3);
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, OwnerUserId) VALUES (6, 1, '2011-06-15 12:00:00', 1, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(STRFTIME('%Y', T2.CreaionDate) = '2011' AND T1.Reputation > 1000, 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId;

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(COUNT("posts"."id") AS REAL) * 100 / (SELECT COUNT("posts"."id") FROM "posts") FROM "posts" INNER JOIN "users" ON "posts"."owneruserid" = "users"."id" WHERE "users"."reputation" > 1000 AND STRFTIME('%Y', "users"."creationdate") = '2011';

/*
Prediction Result:
(0.0,)
*/