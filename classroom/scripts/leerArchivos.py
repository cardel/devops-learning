"""
Script para leer los archivos
"""
import pandas as pd
import numpy as np


gradesData = pd.read_csv("grades.csv")
studentsData = pd.read_csv("students.csv")

#Load data
studentsData = studentsData[["usuario","codigo"]]
gradesData = gradesData[["usuario","points_available","points_awarded"]]

#Delete duplcates
gradesData = gradesData.drop_duplicates()


#Extract usuario
#gradesData["usuario"] = gradesData["student_repository_name"].apply(lambda x: "".join(x.split("-")11:]))


#lowercase usuario column
studentsData["usuario"] = studentsData["usuario"].apply(lambda x: x.lower())
gradesData["usuario"] = gradesData["usuario"].apply(lambda x: x.lower())


#Hacer join de los datos por la columna usuario
totalData = pd.merge(studentsData,gradesData,on="usuario") 

#Attach to column codigo -3743
totalData["codigo"] = totalData["codigo"].apply(lambda x: str(x)+"-3743")

#Calculate grade between 0 and 5
totalData["nota"] = totalData["points_awarded"]/totalData["points_available"]*5

#Save to file 
pd.DataFrame(totalData[["codigo","nota"]]).to_csv("notas.csv",index=False)




