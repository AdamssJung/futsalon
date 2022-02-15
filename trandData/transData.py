import os
import sys
import gspread
import pandas as pd
from oauth2client.service_account import ServiceAccountCredentials
import psycopg2
from sqlalchemy import null

## Function ## match result 유효한 데이터 값만 가져오기
def gt_matchResult(st_data):
    rows = list()
    for x in range(3,30):
        if st_data[x][2] == '-':
            break
        extend_row = list(st_data[x][0:15])
        rows.append(extend_row)
    return rows

def gt_teamResult(st_data):
    rows = list()
    for x in range(3,30):
        if st_data[x][20] == '':
            break
        extend_row = list(st_data[x][20:22])
        rows.append(extend_row)
    return rows    

## Function ## Match Data Insert
def Insert_gameresult(game_data):
    sql = "INSERT INTO tb_gameresult (season) VALUES(%s)"
    cursor.execute(sql, 2021)

## Function ## Player and Team
# def Insert_playerpick(team_result):
#     pick_data = game_data


# Google API 연결 설정 #
scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive',]
work_path = os.getcwd()
resource_path = os.path.join(work_path,'resources')
json_file_name = os.path.join(resource_path,'quiet-amp-275114-083a1f3b2f00.json')
credentials = ServiceAccountCredentials.from_json_keyfile_name(json_file_name, scope)
gc = gspread.authorize(credentials)

# Postres 연결 #
connection = psycopg2.connect(database="db_fs", user="app_fs", password="pok1234@")
cursor = connection.cursor()

# URL List 가져오기 #
sql = "select * from tb_sheeturls"
cursor.execute(sql)
url_data = cursor.fetchall()
print("List of URLS updated")

# 구글시트 url 리스트 #
spreadsheet_url = url_data[0][0] # 1경기 URL

# 스프레스시트 문서 가져오기
doc = gc.open_by_url(spreadsheet_url)
worksheet = doc.sheet1  ## 시트 선택하기
sheet_data = worksheet.get_all_values()  ## 시트 전체 값을 List of List 로 저장

# 3번째 행을 header로 지정
header = sheet_data[2][20:22]
#header = sheet_data[2][0:15]

# Team Select 결과 #
team_result = list(sheet_data[20:22])

#pd_rows = gt_matchResult(sheet_data)
pd_rows = gt_teamResult(sheet_data)

# Pandas 출력
matchdata = pd.DataFrame(pd_rows, columns=header)
matchdata
matchdata.head()
