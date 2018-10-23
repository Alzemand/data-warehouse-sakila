import mysql.connector

cnx = mysql.connector.connect(user='root', password='toor',
                              host='127.0.0.1',
                              database='sakila_dwh')
	

cursor = cnx.cursor()	
							  

for x in range(1000):
	cursor.execute("UPDATE `sakila_dwh`.`dim_film` SET `film_key` = '%d' WHERE (`film_key` = '%d');" % (x,x+1))


cnx.commit()

cursor.close()
cnx.close()