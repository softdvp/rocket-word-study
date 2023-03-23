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
    cells = filter((lambda x: len(x) == 6), cells)
    cells = [[x5.strip().replace('\n', '').replace('  ', ' '), x4.strip().replace('\n', '').replace('  ', ' '), 
        x6.strip().replace('\n', '').replace('  ', ' '), x1.strip().replace('\n', '').replace('  ', ' ')] for (x1, x2, x3, x4, x5, x6) in cells]

    res=''

    for l in cells:
        res+='\t'.join(l)+'\n'

    return res

f=open('pre.htm')
soup = BeautifulSoup(f, 'html.parser')
tables = soup.find_all('table')

Out=''

for table in tables:
    Out+=obtain_table(table)

fout=open('pre.rws', 'w', encoding='utf-8')

#print(Out)

fout.writelines(Out)

fout.close()
