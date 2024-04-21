from typing import List

from classes import Person
from typing import List
import database
import random


async def add_curr_pool(curr_pool: List[Person], curr_strength: int, zone: str):
    """
    add this pool to the database
    We are just adding the user_ids of the person to the table
    - so here make a pool_id which is unique
    - make a query string that has 4 fields and those could be NULL coz its not necessary that there are exactly 4 people in  a pool
    - insert that query into the database
    """
    conn, cursor = database.make_db()
    # making a pool_id
    pool_id = random.randint(1_000, 10_000)
    check_query = f"""
    select * from <table> where pool_id = '{pool_id}'
    """
    cursor.execute(check_query)
    result = cursor.fetchall()
    pool_ids = []
    for each in result:
        pool_ids.append(each[0])
    while pool_id in pool_ids:
        pool_id = random.randint(1_000, 10_000)
    # making the query
    if curr_strength < 4:
        curr_pool.append(Person(None, None, None, None))
    query = f"""
    insert into <table> values ('{pool_id}', '{zone}','{curr_pool[0].user_id}', '{curr_pool[1].user_id}', '{curr_pool[2].user_id}', '{curr_pool[3].user_id}')
    """
    cursor.execute(query)
    conn.commit()
    # we also need to delete this guy from the active pool search table
    for person in curr_pool:
        delete_query = f"""
        delete from <table> where user_id = '{person.user_id}'
        """
        cursor.execute(delete_query)
        conn.commit()
    conn.close()


async def pool_people_zone(data: List[Person], zone: str):
    """
    I have an array of people and each person in that array is a 4-tuple with (min, max, num_people, user_id)
    I need to sort them based on min
    Have a curr_pool array and keep adding people that are being pooled to this array.
    """
    people = sorted(data, key=lambda x: x.min)
    curr_pool = []
    curr_limit = 4
    curr_strength = 0
    for person in people:
        if curr_pool == []:
            curr_pool.append(person)
            curr_strength += person.num_people
            curr_limit = person.max
            if curr_strength == curr_limit:
                await add_curr_pool(curr_pool, curr_strength, zone)
                curr_pool = []
                curr_strength = 0
                curr_limit = 4
            continue
        # Now to extend the pooling
        new_limit = min(curr_limit, person.max)
        if curr_strength + person.num_people > new_limit:
            continue
        curr_pool.append(person)
        curr_strength += person.num_people
        curr_limit = new_limit
        if curr_strength == curr_limit:
            await add_curr_pool(curr_pool, curr_strength, zone)
            curr_pool = []
            curr_strength = 0
            curr_limit = 4
        else:
            continue







