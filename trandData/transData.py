import os
import sys
import datetime
import gspread
import pandas as pd
from urllib.parse import quote
from oauth2client.service_account import ServiceAccountCredentials
from sqlalchemy import create_engine
from sqlalchemy import select

## Function ## match result 유효한 데이터 값만 가져오기
def gt_matchRecord(st_data):
    rows = list()
    for x in range(3,30): 
        if st_data[x][2] == '-': ## 유효한 경기까지만 데이터 가져오기
            break
        extend_row = list(st_data[x][0:15]) ## S 열까지 데이터 가져오기
        rows.append(extend_row)
    return rows

## Function ## matchSummary 유효한 데이터 값만 가져오기
def gt_matchSummary(st_data):
    rows = list()
    for x in range(3,30):
        ## 팀이 비어있으면 for문 종료
        if st_data[x][20] == '':
            break
        ## 팀명단 가져오기
        else:
            if st_data[x][21] == '':
                pass
            ## summary 데이터 가져오기
            else:
                extend_row = list(st_data[x][20:29])
                rows.append(extend_row)
    return rows    

def insert_matchSummary(pd_rows, match_Num, match_Date):
    matchdata = pd.DataFrame(pd_rows, columns= ["match_id","team","name","win","draw","lost"])
    matchdata.insert(0,'mnum',match_Num)
    matchdata.insert(1,'mdate',match_Date)
    print(matchdata)

    # DB ORM 연결, 패스워드 특수문자 치환 #
    engine = create_engine('postgresql://app_fs:%s@localhost:5432/db_fs' % quote('pok1234@'),echo = True) 
    # engine.execute("DROP TABLE IF EXISTS public.tb_test;") # drop table if exists
    # data insert to DBMS Table #
    matchdata.to_sql(
            name = 'tb_matchsummary',
            con = engine,
            schema = 'public',
            if_exists = 'append',
            index = False
            )
    engine.dispose()
    return

# Google API 연결 설정 #
scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive',]
work_path = os.getcwd()
resource_path = os.path.join(work_path,'resources') # resources 디렉토리 path 설정
json_file_name = os.path.join(resource_path,'quiet-amp-275114-083a1f3b2f00.json')              
credentials = ServiceAccountCredentials.from_json_keyfile_name(json_file_name, scope)
gc = gspread.authorize(credentials)

# DB ORM 연결, 패스워드 특수문자 치환 #
engine = create_engine('postgresql://app_fs:%s@localhost:5432/db_fs' % quote('pok1234@'),echo = True) 
result = engine.execute("select * from tb_sheeturls")
url_data = result.fetchall()
engine.dispose()

# 구글시트 url 리스트 #
spreadsheet_url = url_data[0][0] # 1경기 URL
match_NumAndDate = url_data[0][1]
match_Num = match_NumAndDate[:3]
format = '%Y-%m-%d'
match_Date = datetime.datetime.strptime(match_NumAndDate[-8:], "%Y%m%d").date()

# 스프레스시트 문서 가져오기
doc = gc.open_by_url(spreadsheet_url)
worksheet = doc.sheet1  ## 시트 선택하기
sheet_data = worksheet.get_all_values()  ## 시트 전체 값을 List of List 로 저장

# matchSummary Pandas에 저장 #
pd_rows = gt_matchSummary(sheet_data)

# DB Insert #
insert_matchSummary(pd_rows, match_Num, match_Date)

