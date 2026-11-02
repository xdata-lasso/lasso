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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, NULL, NULL, 'Daniel Vassallo', '2023-01-01 01:00:00.000000', NULL, 'default2', NULL, NULL, NULL, 1, 0, NULL, 'Daniel Vassallo'), (1, 1, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, NULL, NULL, 0, 1, NULL, NULL, 0, 'default2'), (2, NULL, NULL, 'Daniel Vassallo', '2023-01-01 01:00:00.000000', 'default2', NULL, 'Daniel Vassallo', 1, NULL, 1, 0, 0, 'default1'), (3, NULL, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default2', 'Daniel Vassallo', NULL, NULL, 0, 1, 1, NULL, 'default2'), (4, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default2', 'default1', 'default1', 1, 1, 1, 0, 0, NULL), (5, 0, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, 'default2', 'default2', 0, 0, NULL, 1, 1, 'default1'), (6, NULL, NULL, NULL, '2023-01-01 00:00:00.000000', 'default1', 'default2', NULL, 1, 0, 1, NULL, 0, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 1, 2, 0, 1, '2023-01-01 01:00:00.000000', 0, NULL, 'default2', '2023-01-01 00:00:00.000000', 'default1', 'Daniel Vassallo', NULL, 1, 1, NULL, NULL, NULL, '2023-01-01 01:00:00.000000', 'Daniel Vassallo', NULL), (1, 6, 4, NULL, 1, '2023-01-01 00:00:00.000000', 1, 0, 'default2', '2023-01-01 00:00:00.000000', 'Daniel Vassallo', 'Daniel Vassallo', NULL, 0, 1, NULL, '2023-01-01 00:00:00.000000', 1, '2023-01-01 01:00:00.000000', 'default1', 'Daniel Vassallo'), (2, 2, 1, NULL, 1, NULL, 0, 1, NULL, NULL, 'default2', 'default2', 0, 1, 1, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default2', 'default1'), (3, 5, 1, NULL, NULL, NULL, NULL, 0, 'Daniel Vassallo', '2023-01-01 00:00:00.000000', NULL, 'default2', NULL, 0, 0, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 0, NULL, NULL, 'Daniel Vassallo');
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (1, 2, 3, 0, 'default1', '2023-01-01 00:00:00.000000', NULL, NULL, 'Daniel Vassallo'), (0, 1, 3, NULL, NULL, '2023-01-01 00:00:00.000000', NULL, 'Daniel Vassallo', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId WHERE T1.DisplayName = 'Daniel Vassallo';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) AS PostCount FROM users INNER JOIN posts ON users.Id = posts.OwnerUserId WHERE users.DisplayName = 'Daniel Vassallo';

/*
Prediction Result:
(1,)
*/