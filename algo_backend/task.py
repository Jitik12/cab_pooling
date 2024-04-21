import database
from pool_people import pool_people_zone
from classes import Person


def make_pool():
    conn, cursor = database.make_db()
    """
    I have a table of people looking for pools stored in postgres, I need to sort them based on zones and start pooling people    
    Lets go zone by zone 
    - Fetch people
    - If there are people in that zone then start pooling them
        - Then move to the next zone
    - If no people then move to the next zone
    """
    zones = ['zone1', 'zone2']
    for zone in zones:
        query = f"""
        select * from <table> where zone = '{zone}'
        """
        cursor.execute(query)
        res = cursor.fetchall()
        my_people = []
        for each in res:
            my_people.append(Person(each[0], each[1], each[2], each[3]))
        if len(res) > 1:
            # Start pooling
            pool_people_zone(my_people, zone)
        else:
            continue
