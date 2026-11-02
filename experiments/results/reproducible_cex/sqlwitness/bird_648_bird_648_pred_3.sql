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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, NULL, NULL, 'default1', '2023-01-01 01:00:00.000000', NULL, 'default2', 'default2', 150, 150, 151, 149, 149, NULL);
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, NULL, NULL, 150, NULL, '2023-01-01 01:00:00.000000', NULL, 150, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default1', NULL, NULL, 150, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 149, NULL, 'default2', 'default2'), (150, NULL, NULL, 1, 151, NULL, 149, 149, NULL, '2023-01-01 01:00:00.000000', 'default1', 'default1', 149, 1, NULL, '2023-01-01 00:00:00.000000', NULL, 0, '2023-01-01 00:00:00.000000', 'default1', 'default2'), (149, NULL, 0, 151, 151, NULL, 1, 149, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, 149, 0, 0, NULL, '2023-01-01 00:00:00.000000', 0, '2023-01-01 00:00:00.000000', 'default1', 'default1'), (1, NULL, 0, 151, 1, '2023-01-01 00:00:00.000000', 149, 149, 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default2', 149, 1, 0, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 1, '2023-01-01 01:00:00.000000', 'default2', 'default2'), (151, 0, 0, 0, 0, '2023-01-01 01:00:00.000000', 151, 150, 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default2', 1, 150, 1, NULL, '2023-01-01 01:00:00.000000', 1, NULL, NULL, 'default2'), (2, 0, NULL, 150, 149, '2023-01-01 00:00:00.000000', 149, 151, 'default2', '2023-01-01 00:00:00.000000', NULL, NULL, 1, 151, 0, NULL, '2023-01-01 01:00:00.000000', 151, '2023-01-01 01:00:00.000000', 'default1', 'default1'), (3, 0, 0, NULL, 1, NULL, 151, 150, NULL, NULL, 'default2', 'default1', 151, 150, 151, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 1, '2023-01-01 00:00:00.000000', NULL, 'default2'), (4, 0, 0, 149, 150, NULL, 1, 149, 'default2', '2023-01-01 01:00:00.000000', NULL, 'default2', 0, 151, 151, '2023-01-01 00:00:00.000000', NULL, 0, '2023-01-01 01:00:00.000000', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName, T1.WebsiteUrl FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE T2.FavoriteCount > 150;

/*
Gold Result:
('default1', None)
('default1', None)
*/

-- Prediction Query
SELECT u.DisplayName, u.WebsiteUrl FROM posts AS p JOIN users AS u ON p.OwnerUserId = u.Id WHERE p.FavoriteCount > 150 AND NOT u.WebsiteUrl IS NULL;

/*
Prediction Result:
*/