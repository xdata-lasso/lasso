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
-- DATASET 1
INSERT INTO users (Id, DisplayName, Reputation) VALUES (1, 'UserOne', 100);
INSERT INTO users (Id, DisplayName, Reputation) VALUES (2, 'UserTwo', 100);
INSERT INTO users (Id, DisplayName, Reputation) VALUES (3, 'UserThree', 100);
INSERT INTO users (Id, DisplayName, Reputation) VALUES (10, 'UserTen', 100);
INSERT INTO users (Id, DisplayName, Reputation) VALUES (20, 'UserTwenty', 100);
INSERT INTO badges (Id, UserId, Name, Date) VALUES (101, 1, 'Teacher', '2020-01-01 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (102, 1, 'Teacher', '2020-01-02 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (103, 1, 'Teacher', '2020-01-03 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (104, 1, 'Teacher', '2020-01-04 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (105, 1, 'Teacher', '2020-01-05 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (106, 1, 'Teacher', '2020-01-06 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (201, 2, 'B1', '2020-01-01 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (202, 2, 'B2', '2020-01-02 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (203, 2, 'B3', '2020-01-03 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (204, 2, 'B4', '2020-01-04 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (205, 2, 'B5', '2020-01-05 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (301, 3, 'C1', '2020-01-01 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (302, 3, 'C2', '2020-01-02 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (303, 3, 'C3', '2020-01-03 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (304, 3, 'C4', '2020-01-04 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (305, 3, 'C5', '2020-01-05 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (306, 3, 'C6', '2020-01-06 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (307, 3, 'C7', '2020-01-07 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (401, 10, 'D1', '2020-01-01 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (402, 10, 'D2', '2020-01-02 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UserId FROM (SELECT UserId, COUNT(Name) AS num FROM badges GROUP BY UserId) AS T WHERE T.num > 5;

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT COUNT(UserId) FROM (SELECT UserId FROM badges GROUP BY UserId HAVING COUNT(Name) > 5) AS T;

/*
Prediction Result:
(2,)
*/