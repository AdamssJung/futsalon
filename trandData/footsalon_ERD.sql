CREATE TABLE "players" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "created_at" timestamp,
  "joined at" varchar,
  "mobile" int,
  "bod" datetime
);

CREATE TABLE "matchinfohistory" (
  "match_id" SERIAL PRIMARY KEY,
  "season" varchar,
  "match_num" int,
  "match_date" date,
  "match_time" varchar,
  "stadium" varchar
);

CREATE index index_season_mnum on matchinfohistory (season, match_num);

CREATE TABLE "awards" (
  "season" varchar,
  "award" varchar,
  "player_id" varchar,
  "prize" varchar
);

CREATE TABLE "match_result" (
  "match_id" int,
  "game_num" int,
  "hTeam" varchar,
  "htScore" int,
  "htHelper" varchar,
  "htKeep "varchar,
  "ATeam" varchar,
  "atScore" integer,
  "atHelper" varchar,
  "atKeep" varchar,
  "goal1" varchar,
  "assist1" varchar,
  "goal2" varchar,
  "Assist2" varchar,
  "goal3" varchar,
  "assist3" varchar
);

create table "tb_matchsummary" (
"match_id" varchar,
"team" varchar,
"name" varchar,
"win" int,
"draw" int,
"lost" int,
"GF" int,
"GA" int
); 

CREATE TABLE "mom" (
  "mom_id" SERIAL PRIMARY KEY,
  "match_id" int,
  "name" varchar,
  "vote" varchar
);

ALTER TABLE "awards" ADD FOREIGN KEY ("player_id") REFERENCES "players" ("id");
ALTER TABLE "awards" ADD FOREIGN KEY ("season") REFERENCES "matchinfohistory" ("season");
ALTER TABLE "match_result" ADD FOREIGN KEY ("match_id") REFERENCES "matchinfohistory" ("match_id");
ALTER TABLE "tb_matchsummary" ADD FOREIGN KEY ("match_id") REFERENCES "matchinfohistory" ("match_id");
ALTER TABLE "mom" ADD FOREIGN KEY ("name") REFERENCES "players" ("name");
ALTER TABLE "mom" ADD FOREIGN KEY ("match_id") REFERENCES "matchinfohistory" ("match_id");