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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 1, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'default2', 'United Kingdom', 'default2', 0, 3, 1, NULL, 0, 'default1'), (4, 3, '2023-01-01 00:00:00.000000', NULL, NULL, 'default1', 'default2', 'United Kingdom', 4, 1, 4, 0, 5, NULL), (0, 0, '2023-01-01 01:00:00.000000', 'United Kingdom', '2023-01-01 00:00:00.000000', 'default1', 'default2', NULL, 4, 3, 1, 0, 3, 'default2'), (5, 3, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'default2', NULL, 5, 1, 0, 0, 0, NULL), (3, 5, NULL, 'United Kingdom', '2023-01-01 00:00:00.000000', 'default1', NULL, 'United Kingdom', 0, 0, 3, NULL, 4, 'default1'), (2, 0, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, 'United Kingdom', 'default2', 4, 3, 3, NULL, 1, 'default2'), (6, 3, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', NULL, 'United Kingdom', 'United Kingdom', 4, 1, NULL, NULL, 3, 'default2'), (7, 3, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default1', 'default2', 'United Kingdom', 1, 4, 0, 0, NULL, NULL), (8, NULL, '2023-01-01 01:00:00.000000', 'United Kingdom', NULL, 'default2', 'default1', 'default1', 5, 4, 5, 3, 5, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (3, 1, 4, 1, 3, NULL, 4, 0, 'United Kingdom', NULL, 'default1', 'United Kingdom', 3, 3, 4, '2023-01-01 01:00:00.000000', NULL, 5, '2023-01-01 01:00:00.000000', NULL, 'default2'), (5, 5, 0, 5, 4, NULL, 4, 4, 'default1', NULL, 'default2', 'default1', 1, 5, 4, '2023-01-01 01:00:00.000000', NULL, 5, '2023-01-01 01:00:00.000000', NULL, 'default2'), (0, 8, NULL, 1, 0, NULL, 0, 4, 'default2', '2023-01-01 01:00:00.000000', 'default2', 'default1', 5, 0, 3, NULL, '2023-01-01 01:00:00.000000', 4, NULL, 'United Kingdom', 'United Kingdom'), (4, 8, 4, 4, 1, NULL, 0, 4, 'default1', '2023-01-01 01:00:00.000000', 'default2', 'United Kingdom', 3, 3, NULL, NULL, '2023-01-01 00:00:00.000000', 4, '2023-01-01 00:00:00.000000', NULL, 'default2'), (1, 7, 2, 4, 4, NULL, 4, 5, NULL, '2023-01-01 01:00:00.000000', 'default1', 'default2', NULL, 1, 5, '2023-01-01 00:00:00.000000', NULL, 5, '2023-01-01 00:00:00.000000', 'default1', 'United Kingdom'), (2, 0, 6, 1, 1, '2023-01-01 01:00:00.000000', 5, NULL, 'default1', '2023-01-01 00:00:00.000000', 'default1', 'United Kingdom', 5, NULL, 4, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 4, '2023-01-01 00:00:00.000000', 'default1', NULL), (6, 5, 3, 0, 0, NULL, NULL, 5, 'default2', '2023-01-01 01:00:00.000000', 'United Kingdom', 'default1', 1, NULL, 0, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default2', 'default1'), (7, 2, 2, 5, NULL, '2023-01-01 00:00:00.000000', NULL, 5, 'default2', NULL, 'default2', 'default2', 0, 0, 4, NULL, NULL, NULL, '2023-01-01 01:00:00.000000', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE T1.Location = 'United Kingdom' AND T2.FavoriteCount >= 4;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT u.Id) FROM users AS u INNER JOIN posts AS p ON u.Id = p.OwnerUserId WHERE u.Location = 'United Kingdom' AND p.FavoriteCount >= 4;

/*
Prediction Result:
(2,)
*/