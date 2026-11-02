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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1465, 3556, '1987-10-21', 'Alejandra Price', '1991-03-02', 'http://delacruz-schmidt.com/', '0843 Matthew Lock Apt. 168
South John, FL 56398', 'her', 3560, 3564, 3568, 3572, 3576, 'https://www.mathis.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3553, 3561.0, '1987-10-22', 'Samuel Keller', '1991-03-03', 'http://house.net/', 'Unit 9578 Box 2329
DPO AP 90160', 'base', 3579.0, 3585.0, 3591.0, 3597.0, 3603.0, 'https://taylor-lee.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3554, 3566.0, '1987-10-23', 'Alicia Dillon', '1991-03-04', 'https://long-moore.com/', '8262 Lonnie Point
East Lonnieberg, VA 04365', 'rise', 3598.0, 3606.0, 3614.0, 3622.0, 3630.0, 'https://www.clements-walker.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3555, 3571.0, '1987-10-24', 'Crystal James', '1991-03-05', 'https://turner.com/', '4742 Daniel Ferry Apt. 994
New Jesse, TX 03919', 'state', 3617.0, 3627.0, 3637.0, 3647.0, 3657.0, 'http://www.ho.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3632, 3640.0, '1990-09-08', 'Stephanie Ford', '1994-02-12', 'http://wright.com/', '09407 Foley Plains
New Nicolebury, IL 77684', 'author', 3658.0, 3664.0, 3670.0, 3676.0, 3682.0, 'https://clark.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3633, 3645.0, '1990-09-09', 'Ann Mason', '1994-02-13', 'http://www.mccarthy.com/', '7199 John Plaza Suite 983
East Eddiestad, AZ 19555', 'son', 3677.0, 3685.0, 3693.0, 3701.0, 3709.0, 'http://barker.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3634, 3650.0, '1990-09-10', 'Kevin Shannon', '1994-02-14', 'http://moody.biz/', '1016 Evan Haven Apt. 795
North Kaylamouth, MN 50169', 'late', 3696.0, 3706.0, 3716.0, 3726.0, 3736.0, 'https://fox-carney.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3600, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3679, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3580, 3584, 3588, '1995-07-06', 3592, 3596, 'garden', 3600, '1970-11-10', 'Fine artist', 'political', 3604, 3608, 3778.0, 1465, '1974-04-14', '1978-08-18', 3616, '1982-01-22', 'Jennifer Crosby', 'Joshua Terrell');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3582, 3589.0, 3595.0, '1995-07-07', 3603.0, 3609.0, 'trial', 3600, '1970-11-11', 'Physiotherapist', 'simple', 3629.0, 3635.0, 3641.0, 1465, '1974-04-15', '1978-08-19', 3653.0, '1982-01-23', 'Kimberly Davidson', 'James Hubbard');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3583, 3594.0, 3602.0, '1995-07-08', 3614.0, 3622.0, 'lot', 3600, '1970-11-12', 'Ophthalmologist', 'thank', 3654.0, 3662.0, 3670.0, 1465, '1974-04-16', '1978-08-20', 3690.0, '1982-01-24', 'Amanda Rodriguez', 'Cheryl Gonzales');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3659, 3599.0, 3609.0, '1995-07-09', 3625.0, 3635.0, 'very', 3600, '1970-11-13', 'Architectural technologist', 'husband', 3679.0, 3689.0, 3699.0, 1465, '1974-04-17', '1978-08-21', 3727.0, '1982-01-25', 'Shawn Rich', 'Patricia Mitchell');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3581, 3663, 3667, '1998-06-15', 3671, 3675, 'within', 3679, '1973-10-19', 'Research scientist (medical)', 'early', 3683, 3687, 3778.0, 1465, '1977-03-23', '1981-07-04', 3695, '1985-11-08', 'Alexander Garrett', 'Elizabeth Hunter');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3660, 3668.0, 3674.0, '1998-06-16', 3682.0, 3688.0, 'carry', 3679, '1973-10-20', 'Research officer, government', 'section', 3708.0, 3714.0, 3720.0, 1465, '1977-03-24', '1981-07-05', 3732.0, '1985-11-09', 'Ryan Marsh', 'Aaron Jennings');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3661, 3673.0, 3681.0, '1998-06-17', 3693.0, 3701.0, 'model', 3679, '1973-10-21', 'Education administrator', 'fill', 3733.0, 3741.0, 3749.0, 1465, '1977-03-25', '1981-07-06', 3769.0, '1985-11-10', 'Mrs. Felicia Castro DDS', 'Nathaniel Gilbert');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3662, 3678.0, 3688.0, '1998-06-18', 3704.0, 3714.0, 'nature', 3679, '1973-10-22', 'Travel agency manager', 'daughter', 3758.0, 3768.0, 3612, 1465, '1977-03-26', '1981-07-07', 3806.0, '1985-11-11', 'Curtis Campbell', 'Christopher Rivera');
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3621, 3580, 3624, '1986-05-03', 1465, 3628);
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3622, 3580, 3631.0, '1986-05-04', 1465, 3641.0);
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3623, 3580, 3638.0, '1986-05-05', 1465, 3654.0);
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3699, 3580, 3645.0, '1986-05-06', 1465, 3667.0);
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3620, 3581, 3625, '1989-04-12', 1465, 3629);
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3700, 3581, 3710.0, '1989-04-13', 1465, 3720.0);
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3701, 3581, 3717.0, '1989-04-14', 1465, 3733.0);
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3702, 3581, 3724.0, '1989-04-15', 1465, 3746.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Id FROM votes AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T1.UserId = 1465 ORDER BY T2.FavoriteCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
(3581,)
*/

-- Prediction Query
SELECT p.Id FROM posts AS p JOIN votes AS v ON p.Id = v.PostId WHERE v.UserId = 1465 ORDER BY p.FavoriteCount DESC, p.id NULLS LAST, v.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(3580,)
*/