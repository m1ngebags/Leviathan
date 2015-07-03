#this is a bad idea
#this file shouldn't even exist

#yolo

from pymongo import MongoClient

client = MongoClient()
db = client['leviathan']

db['accounts'].drop()
