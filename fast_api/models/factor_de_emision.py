'''CREATE TABLE FACTOR_DE_EMISION(
ID_FACTOR_EMISION int,
FUENTE_EMISION varchar(150) not null, --Caldera - Gas licuado de petróleo
COMBUSTIBLE varchar(100),
ORIGEN_DEL_FE varchar(100),	
INCERTIDUMBRE varchar(10), -- Alta, Media, Baja
ID_UNIDAD_FACTOR_EMISION int,
ID_FUENTE int, --Caldera - Gas licuado de petróleo
PRIMARY KEY(ID_FACTOR_EMISION),
    CONSTRAINT fk_fe_unidad_fe
      FOREIGN KEY(ID_UNIDAD_FACTOR_EMISION) 
        REFERENCES UNIDAD_FACTOR_EMISION(ID_UNIDAD_FACTOR_EMISION),
    CONSTRAINT fk_fe_Fuente
      FOREIGN KEY(ID_FUENTE) 
        REFERENCES FUENTE(ID_FUENTE)
);'''

from pydantic import BaseModel, Field
from typing import Optional
from datetime import date, datetime

class FactorDeEmision(BaseModel):

  # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_FACTOR_EMISION: int = Field(gt=0)
    FUENTE_EMISION: str = Field(min_length=5, max_length=150)
    COMBUSTIBLE: str = Field(min_length=5, max_length=100)
    ORIGEN_DEL_FE: str = Field(min_length=5, max_length=100)
    INCERTIDUMBRE: str = Field(min_length=5, max_length=10)
    ID_UNIDAD_FACTOR_EMISION : int = Field(gt=0)
    ID_FUENTE: int = Field(gt = 0)
