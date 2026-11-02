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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (687, 687, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', '2011', NULL, 'default2', 685, 0, 687, 685, 1, '%Y'), (686, NULL, '2023-01-01 00:00:00.000000', '%Y', '2023-01-01 01:00:00.000000', NULL, '2011', '2011', 686, 686, 687, 686, 1, 'default2');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (685, 686, NULL, 687, NULL, '2023-01-01 01:00:00.000000', 1, 1, NULL, '2023-01-01 01:00:00.000000', NULL, NULL, 1, 687, 687, '2023-01-01 00:00:00.000000', '2011-10-27 00:00:00.000000', 1, '2023-01-01 00:00:00.000000', NULL, 'default2'), (1, 687, 686, 686, 1, NULL, 685, 685, NULL, '2011-10-27 00:00:00.000000', 'default1', '%Y', 685, 1, 687, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', '2011', NULL), (687, NULL, NULL, 685, 686, '2011-10-27 00:00:00.000000', 687, NULL, '2011', NULL, '2011', '2011', 1, 685, 1, '2023-01-01 00:00:00.000000', NULL, 0, NULL, '2011', 'default2');
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (686, NULL, 687, 0, 'default2', '2023-01-01 01:00:00.000000', '2011', '2011', '2011'), (1, 1, 686, 0, 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default1', NULL), (685, NULL, NULL, 1, '%Y', '2023-01-01 01:00:00.000000', 'default2', 'default1', '2011'), (687, 685, 686, 685, NULL, '2011-10-27 00:00:00.000000', '%Y', NULL, 'default1'), (0, 687, NULL, 1, 'default1', NULL, 'default2', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(DISTINCT FavoriteCount) FROM posts WHERE Id IN (SELECT PostId FROM postHistory WHERE UserId = 686 AND STRFTIME('%Y', CreationDate) = '2011');

/*
Gold Result:
(687,)
*/

-- Prediction Query
SELECT SUM(FavoriteCount) AS TotalFavorites FROM posts WHERE OwnerUserId = 686 AND STRFTIME('%Y', CreaionDate) = '2011';

/*
Prediction Result:
(None,)
*/