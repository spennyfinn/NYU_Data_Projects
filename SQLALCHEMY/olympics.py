import configparser
from operator import itemgetter

import sqlalchemy
from sqlalchemy import create_engine

# columns and their types, including fk relationships
from sqlalchemy import Column, Integer, Float, String, DateTime
from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship

# declarative base, session, and datetime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from datetime import datetime

# configuring your database connection
config = configparser.ConfigParser()
config.read('config.ini')
u, pw, host, db = itemgetter('username', 'password', 'host', 'database')(config['db'])
dsn = f'postgresql://{u}:{pw}@{host}/{db}'
print(f'using dsn: {dsn}')

# SQLAlchemy engine, base class and session setup
engine = create_engine(dsn, echo=True)
Base = declarative_base()
Session = sessionmaker(engine)
session = Session()

# TODO: Write classes and code here

class AthleteEvent(Base):
    __tablename__ = 'athlete_event'
    
    id = Column(Integer, primary_key=True)
    name = Column(String)
    age = Column (Integer)
    team = Column(String)
    medal = Column(String)
    year = Column(Integer)
    season = Column(String)
    city = Column(String)
    noc = Column(String, ForeignKey("noc_region.noc"))
    sport = Column(String)
    event = Column(String)
    noc_region = relationship("NOCRegion", back_populates='athlete_events')

    def __str__(self):
        return f"name: {self.name}, noc: {self.noc}, season: {self.season}, year: {self.year}, event: {self.event}, medal: {self.medal}"

    def __repr__(self):
        return f"name: {self.name}, noc: {self.noc}, season: {self.season}, year: {self.year}, event: {self.event}, medal: {self.medal}"
        
class NOCRegion(Base):
    __tablename__ = 'noc_region'

    noc = Column(String, 
                 
                 primary_key=True)
    region = Column(String)
    athlete_events = relationship("AthleteEvent", back_populates="noc_region")

    def __str__(self):
        return f"noc: {self.noc}, region: {self.region}"

    def __repr__(self):
        return self.__str__()


Yuto = AthleteEvent()
Yuto.id = 1
Yuto.name = 'Yuto'
Yuto.age=21
Yuto.team = 'Japan'
Yuto.medal = 'Gold'
Yuto.year = 2020
Yuto.season = 'Summer'
Yuto.city = 'Tokyo'
Yuto.noc = 'JPN'
Yuto.sport = 'Skateboarding'
Yuto.event = 'Skateboarding, Street, Men'
session.add(Yuto)


from sqlalchemy import select

q = select(AthleteEvent).where(
    AthleteEvent.noc == 'JPN',
    AthleteEvent.year >= 2016,
    AthleteEvent.medal == 'Gold'
)

session.scalar(q)

session.commit()



session.close()

