import mysql.connector

cnx = mysql.connector.connect(user='root', password='toor',
                              host='127.0.0.1',
                              database='sakila_dwh')
	

cursor = cnx.cursor()	
							  

for x in range(600):
	cursor.execute("UPDATE `sakila_dwh`.`dim_customer` SET `customer_key` = '%d' WHERE (`customer_key` = '%d');" % (x,x+1))


cnx.commit()

cursor.close()
cnx.close()