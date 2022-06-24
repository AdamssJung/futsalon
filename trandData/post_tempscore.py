import os
import sys
import gspread
import pandas as pd
from urllib.parse import quote
from oauth2client.service_account import ServiceAccountCredentials
from sqlalchemy import create_engine
from sqlalchemy import select

## Function ## matchSummary 유효한 데이터 값만 가져오기
def gt_tempscore(st_data):
    rows = list()
    for x in range(3,30):
        ## 점수 비어있으면 for문 종료
        if st_data[x][3] == '-':
            break
        ## 기록 가져오기
        else:
            if st_data[x][10] == '':
                pass
            ## 기록 데이터 가져오기
            else:
                extend_row = list(st_data[x][10:16])
                rows.append(extend_row)
    return rows

######### Main Program ###########

# Google API 연결 설정 #
scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive',]
work_path = os.getcwd()
resource_path = os.path.join(work_path,'resources') # resources 디렉토리 path 설정
json_file_name = os.path.join(resource_path,'quiet-amp-275114-083a1f3b2f00.json')              
credentials = ServiceAccountCredentials.from_json_keyfile_name(json_file_name, scope)
gc = gspread.authorize(credentials)
# Get Google Sheet URL from tb_sheeturls table

# DB ORM 연결, 패스워드 특수문자 치환 #
engine = create_engine('postgresql://app_fs:%s@localhost:5432/db_fs' % quote('pok1234@'),echo = True) 
result = engine.execute("select * from tb_sheeturls order by name ASC")
url_data = result.fetchall()
engine.dispose()

for x in range (0,29):
    # 구글시트 url 리스트 #
    spreadsheet_url = url_data[x][0] # 1경기 URL
    # 스프레스시트 문서 가져오기
    doc = gc.open_by_url(spreadsheet_url)
    worksheet = doc.sheet1  ## 시트 선택하기
    sheet_data = worksheet.get_all_values()  ## 시트 전체 값을 List of List 로 저장
        # pandas 로 data 가져오기
    pd_rows = gt_tempscore(sheet_data)
    scoredata = pd.DataFrame(pd_rows, columns= ["gol1","ass1","gol2","ass2","gol3","ass3"])
    mnum_org = url_data[x][1].lower()
    mnum = mnum_org[0:3]
    matchid = "s09" + mnum
    scoredata.insert(0,'match_id',matchid)
    # DB ORM 연결, 패스워드 특수문자 치환 #
    engine = create_engine('postgresql://app_fs:%s@localhost:5432/db_fs' % quote('pok1234@'),echo = True) 
    # data insert to DBMS Table #
    scoredata.to_sql(
            name = 'tb_tempscore',
            con = engine,
            schema = 'public',
            if_exists = 'append',
            index = False
            )
    engine.dispose()
