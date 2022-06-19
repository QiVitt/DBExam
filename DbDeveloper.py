
# import mysql.connector

# db = mysql.connector.connect(host = 'localhost', user = 'root', password = 'DatabaseForSure525', database = 'classicmodels')

# if (db.is_connected( )) :
#     print("\n Connection Established \n")


# cursore = db.cursor( )

# sql = "SELECT * FROM customers WHERE contactLastName = %s"

# adr = ("Smith", )

# cursore.execute(sql, adr)

# results = cursore.fetchall( )

# for line in results:
    
#     print(line)

# db.close( )

import mysql.connector

db = mysql.connector.connect(host = 'localhost', user = 'root', password = 'DatabaseForSure525', database = 'Dbexam')

if (db.is_connected( )) :
    print("\n Connection Established \n")

cursore = db.cursor( )

def Menu( ):

    while (True) :

        print(' Selezionare un valore ')
        print(' 0. CLOSE sessione')
        print(' 1. INSERT nuovo paziente ')
        print(' 2. SELECT visite paziente ')
        print(' 3. SELECT medicinale paziente ')

        i = int( input(' \n ') )

        if (i == 0) :
            
            db.close( )

            print('\n Goodbye \n')

            return

        if (i == 1) : Newpaziente( )
        if (i == 2) : Visitepaziente( )
        if (i == 3) : Medicinalepaziente( )    


def Newpaziente( ):

    print('\n Note : Inizialmente viene accettato solo il Codice Fiscale \n')

    medico = int( input(' Quale medico deve essere selezionato ? (CRM) ') )

    medico = (medico, )

    cf = input( ' Inserire il Codice Fiscale del paziente ')

    mail = input(' Inserire la Mail del paziente ')

    cell = input(' Inserire il Cellulare del paziente ')

    sql = "INSERT INTO Paziente (Dbexam.Paziente.ID, Dbexam.Paziente.CRM) VALUES (NULL, %s) ;"
    
    cursore.execute(sql, medico)

    results = cursore.fetchall( )

    for line in results:
        
        print(line)
    
    sql = "SELECT MAX(ID) FROM Paziente ;"
    
    cursore.execute(sql)

    results = cursore.fetchall( )

    maxe = results[0][0]

    adr = (maxe, cf, mail, cell)

    sql = "INSERT INTO DataAnagrafica (ID, CodiceFiscale, Email, Cell) VALUES (%s, %s, %s, %s) ;"

    cursore.execute(sql, adr)

    results = cursore.fetchall( )

    for line in results:
        
        print(line)
    
    db.commit( )
    
    print('\n All done con successo \n')

    return 

def Visitepaziente( ):

    id = input('\n Di che paziente si vogliono vedere le visite ? (ID) ')

    id = (id, )

    sql = "SELECT * FROM Svolgimento WHERE ID = %s ;"

    cursore.execute(sql, id)

    results = cursore.fetchall( )

    print(' ')

    for line in results:
        
        print(line)
    
    print('\n All done con successo \n')

    return 

def Medicinalepaziente( ):

    id = input('\n Di che paziente si vogliono vedere i medicinali ? (ID) ')

    id = (id, )

    sql = "SELECT * FROM Assunzione WHERE ID = %s ;"

    cursore.execute(sql, id)

    results = cursore.fetchall( )

    print(' ')

    for line in results:
        
        print(line)
    
    print('\n All done con successo \n')

    return 

Menu( )