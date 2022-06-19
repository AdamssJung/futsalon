## Footsalon ERD ##
CREATE TABLE "tb_players" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "joined at" varchar,
  "mobile" int,
  "bod" date
);

CREATE TABLE "tb_matchinfohistory" (
  "match_id" varchar PRIMARY KEY,
  "season" varchar,
  "match_num" int,
  "match_date" date,
  "match_time" varchar,
  "stadium" varchar
);

CREATE index index_season_mnum on matchinfohistory (season, match_num);

CREATE TABLE "tb_awards" (
  "season" varchar,
  "award" varchar,
  "player_id" varchar,
  "prize" varchar
);

CREATE TABLE "tb_match_result" (
  "game_id" varchar PRIMARY KEY,
  "match_id" varchar,
  "hTeam" varchar,
  "htScore" int,
  "htHelper" varchar,
  "htKeep "varchar,
  "ATeam" varchar,
  "atScore" integer,
  "atHelper" varchar,
  "atKeep" varchar,
);

CREATE TABLE "tb_Score" (
  "goal_id" SERIAL PRIMARY KEY,
  "match_id" varchar,
  "game_id" varchar,
  "goal" varchar,
  "assist" varchar,
);

create table "tb_matchsummary" (
"match_id" varchar PRIMARY KEY,
"team" varchar,
"name" varchar,
"win" int,
"draw" int,
"lost" int,
"GF" int,
"GA" int
); 

CREATE TABLE "tb_mom" (
  "mom_id" SERIAL PRIMARY KEY,
  "match_id" varchar,
  "voter" varchar,
  "mom" varchar
);

ALTER TABLE "tb_awards" ADD FOREIGN KEY ("player_id") REFERENCES "tb_players" ("id");
ALTER TABLE "tb_awards" ADD FOREIGN KEY ("season") REFERENCES "tb_matchinfohistory" ("season");
ALTER TABLE "tb_match_result" ADD FOREIGN KEY ("match_id") REFERENCES "tb_matchinfohistory" ("match_id");
ALTER TABLE "tb_GoalHistory" ADD FOREIGN KEY ("match_id") REFERENCES "tb_matchinfohistory" ("match_id");
ALTER TABLE "tb_matchsummary" ADD FOREIGN KEY ("match_id") REFERENCES "tb_matchinfohistory" ("match_id");
ALTER TABLE "tb_mom" ADD FOREIGN KEY ("match_id") REFERENCES "tb_matchinfohistory" ("match_id");

https://docs.google.com/spreadsheets/d/1KQkk_zKzdDziVBGdsh1YuBW4dEL_oZslJ724wRNjLkQ	M01_20210704
https://docs.google.com/spreadsheets/d/1mMgwTIRf_1Ohw04lhAsyfvH7iZ681nrDvimUCBWpMbU	M02_20210711
https://docs.google.com/spreadsheets/d/1lvKLA_r-FUZvXCpnGPNMGMjyc2tfvk9xL7kB5Dd2ISM	M03_20210718
https://docs.google.com/spreadsheets/d/1_6DpvfyeUXqvaalhytHP-5281QyXx18WmPUFQeL48mo	M04_20210725
https://docs.google.com/spreadsheets/d/1R2P1vfqhNtjlD8sAxevdixIlL4QnTdzXUid0r4pzaRg	M05_20211107
https://docs.google.com/spreadsheets/d/1pMP_MHCUiw5JDAt4p-I2Xt95HD8D7jzxEMZvio8x2EU	M06_20211114
https://docs.google.com/spreadsheets/d/1aZ_qMrcPrBPiOzW0_TXie_013YiIe-osmTf-9vhTnOM	M07_20211121
https://docs.google.com/spreadsheets/d/1CNZO_KZsiDoMmDBM3uD_YMGhyN2Tph_ueXbUyBIHJ9Y	M08_20211128
https://docs.google.com/spreadsheets/d/1AVNNAMuYZtdu9hm7rFIXsHhybsTLdayOtoBrGKv-ZdE	M09_2021212
https://docs.google.com/spreadsheets/d/1O-qpYZptSAyAc7c5Jexq4ofBSgjuHIGS6kQ0Nrbehdo	M10_2021219
https://docs.google.com/spreadsheets/d/1tTqpM8zx6uqBWtDQeOuA9UsbVnvjruQF08Ln5PIA2cE	M11_2021226
https://docs.google.com/spreadsheets/d/1Iu5eezdUyqUCSjY5IDuRvMAKX3sqiVEzeo07-nDtjeE	M12_20220109
https://docs.google.com/spreadsheets/d/1r63WhXdP2L0dhF3FJ8VOfm-8xtiwOpFg5r4PB8rhslQ	M13_20220116
https://docs.google.com/spreadsheets/d/14ey0LTU7wKwTWuvwzq-yxpzTxc18IGaX4CYYQD2iRjU	M14_20220123
https://docs.google.com/spreadsheets/d/1BNoXTRNdZEFh4Gw1otauY5EHJ8HFi7MC8s7XkZHuh6o	M15_20220206
https://docs.google.com/spreadsheets/d/1XrQhBb-gZM3abMA0N36YJ_EWkNdPOCDbEuMe1JQtprA	M16_20220213
https://docs.google.com/spreadsheets/d/1mtMJVesDDz42Y5XCf__DM6W1u9eTUcsiVkQUO3E2pKY	M17_20220220
https://docs.google.com/spreadsheets/d/1MiUJbEhvSEEeyK_ywc06Hm4WFeaOgFvLBdhSZbjeGqw	M18_20220227
https://docs.google.com/spreadsheets/d/1vUt_7xRdeGMNjzv7j1BBe4UlvAW3cgJ9gtm8nKy4uWY	M19_20220306
https://docs.google.com/spreadsheets/d/1a0vO01rZy5nAS3UAXkLL8M9vu_7bP2fCy9-amNyyTlA	M20_20220313
https://docs.google.com/spreadsheets/d/1WY1l-Gsa5Vtl5IXjORUSvFtxpGXHUYyPZ4YM3Tf1cjs	M21_20220327
https://docs.google.com/spreadsheets/d/1ZbPzS1xahgrKuj_9JM1mOW-OL_ARDol6x1YaigmQfks	M22_20220410
https://docs.google.com/spreadsheets/d/13FGj3Zbnw0V-wYB8vR7ePOmdrfEkvnjTblYs7TbOtwc	M23_20220417
https://docs.google.com/spreadsheets/d/1GNS5fe3bZwzHLyIG0yGrDtLPyQU6-bBmDmRq3lw1lAU	M24_20220424
https://docs.google.com/spreadsheets/d/1tO1ZiJ_wnMhCKkEkP93A7tfMjKYXQMFFHeC5zenwM4o	M25_20220501
https://docs.google.com/spreadsheets/d/1e3dVmQElmEVLZCFxDS9Qm8jR5ZgKYFJwYBBH7-599lI	M26_20220515
https://docs.google.com/spreadsheets/d/1SWu9YZsEC42WmQD4jMajku03PBdt7NfFOYHTS5M8xuc	M27_20220522
https://docs.google.com/spreadsheets/d/1M8YZ5nGzraKFhCuOl547cV5dfKFwVASqQr1Nx0ZjqvA	M28_20220529
https://docs.google.com/spreadsheets/d/1ESo20zy6LdWsnsXIsiQdRi4r1H9maO4sZEnSxyTMOOM	M29_20220619