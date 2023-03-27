"""
		This Source Code Form is subject to the terms of the MIT
		License. 

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)
"""


from bs4 import BeautifulSoup
import sys

def obtain_table(table):
    cells = [[cell.text for cell in row.find_all(['td','th'])] for row in table.find_all('tr')]
    cells = filter((lambda x: len(x) == 4), cells)
    cells = [[x2.strip().replace('\n', '').replace('  ', ' '), x1.strip().replace('\n', '').replace('  ', ' '), 
        x3.strip().replace('\n', '').replace('  ', ' '), x4.strip().replace('\n', '').replace('  ', ' ')] for (x1, x2, x3, x4) in cells]

    res=''

    for l in cells:
        res+='\t'.join(l)+'\n'

    return res

f=open('topical.html')
soup = BeautifulSoup(f, 'html.parser')
tables = soup.find_all('table')

Out=''

for table in tables:
    Out+=obtain_table(table)

fout=open('topical.rws', 'w', encoding='utf-8')

#print(Out)

fout.writelines(Out)

fout.close()
