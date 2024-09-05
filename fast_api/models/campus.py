'''CREATE TABLE CAMPUS(
ID_CAMPUS int,
ID_PROYECTO int not null,
NOMBRE varchar(100),
HUELLA_DE_CARBONO numeric(30,10),
HUELLA_HIDRICA numeric(30,10),
HUELLA_FINANCIERA numeric(30,10),
PRIMARY KEY(ID_CAMPUS),
   CONSTRAINT fk_c_proyecto
      FOREIGN KEY(ID_PROYECTO) 
        REFERENCES PROYECTOS(ID_PROYECTO)
);'''

from pydantic import BaseModel, Field
from typing import Optional
from datetime import date, datetime

class Campus(BaseModel):

  # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_CAMPUS: int = Field(gt=0)
    ID_PROYECTO: int = Field(gt=0)
    NOMBRE: str = Field(min_length=5, max_length=100)
    HUELLA_DE_CARBONO: float = Field(gt=0)
    HUELLA_HIDRICA: float = Field(gt=0)
    HUELLA_FINANCIERA: float = Field(gt=0)

