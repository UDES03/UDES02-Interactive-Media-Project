import csv
import requests
import os

fromDate = '2022-08-11T00:00:00'
toDate = '2022-08-12T00:00:00'
sensor = 'CB11.PC00.06.West'
subSensor = 'CB11.00.Wattle+In'

url = 'https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=' + fromDate + '&rToDate=' + toDate +'&rFamily=people_sh&rSensor=' + sensor + '&rSubSensor=' + subSensor

sensors = ['CB11.PC00.06.West', 'CB11.PC00.08.ST12', 'CB11.PC00.09.CR01', 'CB11.PC02.16.JonesStEast', 'CB11.PC05.22', 'CB11.PC05.23', 'CB11.PC09.27', 'CB11.PC09.28', 'CB11.PC10.30', 'CB11.PC02.14.Broadway']
subSensors = [['CB11.00.Wattle In', 'CB11.00.Wattle Out'],['CB11.00.CR04.East In', 'CB11.00.CR04.East Out', 'CB11.00.ST01 Down', 'CB11.00.ST01 Up'], ['CB11.00.CR04.West In', 'CB11.00.CR04.West Out'], ['CB11.02.JonesSt In', 'CB11.02.JonesSt Out'], ['CB11.04.ST18 Down', 'CB11.04.ST19 Down', 'CB11.04.ST18 Up', 'CB11.04.ST19 Up'], ['CB11.05.CR07 Out', 'CB11.05.CR07 In', 'CB11.05.CR09 Out', 'CB11.05.CR09 In'], ['CB11.09.ST22 Down', 'CB11.09.ST22 Up'], ['CB11.08.CR10 In', 'CB11.08.CR10 Out', 'CB11.09.CR12 In', 'CB11.09.CR12 Out', 'CB11.09.ST21 Up', 'CB11.09.CR14 In', 'CB11.09.CR14 Out', 'CB11.09.ST21 Down'], ['CB11.10.CR09 In', 'CB11.10.CR09 Out', 'CB11.09.CR11 Out', 'CB11.09.CR11 In'], ['CB11.02.Broadway.East In', 'CB11.02.Broadway.East Out']]

for i, s in enumerate(sensors):
    if not os.path.exists('data/'+str(s)):
        os.mkdir('data/'+str(s))
    for ss in subSensors[i]:
        url = 'https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=' + fromDate + '&rToDate=' + toDate +'&rFamily=people_sh&rSensor=' + s + '&rSubSensor=' + ss.replace(' ', '+')
        response = requests.get(url)     

        with open('data/' + s + '/' + ss + '.csv', 'w', newline='') as f:
            writer = csv.writer(f)
            for line in response.iter_lines():
                writer.writerow(line.decode('utf-8').split(','))