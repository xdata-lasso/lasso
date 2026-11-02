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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (7, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, 'default2', 'default1', 0, 1, 1, NULL, 9, 'default2'), (9, 8, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', 9, 9, 8, 9, 2, 'default1'), (2, 0, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default1', NULL, 'default1', NULL, 1, 7, 0, 8, NULL);
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (2, 7, 7, 7, 8, NULL, 2, 1, NULL, '2023-01-01 01:00:00.000000', 'default2', NULL, 2, 0, 8, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 9, '2023-01-01 00:00:00.000000', NULL, 'default2'), (9, NULL, NULL, 7, 8, NULL, NULL, NULL, 'default1', '2023-01-01 00:00:00.000000', NULL, 'default2', NULL, 7, 2, NULL, NULL, NULL, '2023-01-01 01:00:00.000000', 'default2', NULL), (7, 7, NULL, 0, NULL, '2023-01-01 01:00:00.000000', 9, NULL, 'default1', '2023-01-01 00:00:00.000000', 'default2', NULL, 9, 9, 8, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 0, NULL, 'default1', NULL), (0, 9, NULL, 7, NULL, NULL, 7, 0, 'default2', NULL, NULL, 'default1', 9, 2, 7, NULL, '2023-01-01 01:00:00.000000', NULL, NULL, NULL, NULL), (8, 9, 9, 9, 7, NULL, NULL, NULL, 'default2', NULL, 'default1', NULL, 0, 2, 9, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 1, NULL, 'default2', NULL), (1, 9, 7, 7, NULL, '2023-01-01 00:00:00.000000', 0, 8, 'default1', '2023-01-01 01:00:00.000000', NULL, NULL, 1, 1, 1, '2023-01-01 00:00:00.000000', NULL, 1, NULL, NULL, NULL);
INSERT INTO votes (id, postid, userid, votetypeid, creationdate, bountyamount) VALUES (7, 2, 7, NULL, NULL, 9), (9, 1, 9, 9, '2023-01-01', 8), (2, NULL, 2, 0, '2023-01-02', 8), (8, 2, NULL, 2, '2023-01-02', 8), (1, 9, 2, 8, '2023-01-02', 0), (0, 2, 7, 8, NULL, 1), (3, 7, 2, 2, '2023-01-02', 8), (4, 9, NULL, 1, '2023-01-02', 1), (5, NULL, NULL, NULL, '2023-01-01', 0), (6, 1, 2, 9, '2023-01-02', NULL), (10, 8, 9, 7, NULL, 1), (11, 9, 2, 8, '2023-01-01', 1), (12, 1, 2, 0, NULL, 2), (13, 1, 7, 2, NULL, 1), (14, 8, 2, 0, '2023-01-01', NULL), (15, 1, NULL, NULL, '2023-01-02', 7), (16, 7, 2, 9, NULL, 1), (17, 7, 2, 7, '2023-01-02', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DisplayName, WebsiteUrl FROM users WHERE Id = (SELECT UserId FROM votes WHERE VoteTypeId = 8 ORDER BY BountyAmount DESC, votes.id NULLS LAST LIMIT 1);

/*
Gold Result:
('default2', None)
*/

-- Prediction Query
SELECT T1.DisplayName, T1.WebsiteUrl FROM users AS T1 INNER JOIN votes AS T2 ON T1.Id = T2.UserId WHERE T2.VoteTypeId = 8 ORDER BY T2.BountyAmount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1', 'default1')
*/