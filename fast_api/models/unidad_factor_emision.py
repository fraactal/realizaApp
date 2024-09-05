'''CREATE TABLE UNIDAD_FACTOR_EMISION(
ID_UNIDAD_FACTOR_EMISION int,
NOMBRE varchar(100) not null,  -- kgCO2eq/litros
PRIMARY KEY(ID_UNIDAD_FACTOR_EMISION)
);'''

from pydantic import BaseModel, Field
from typing import Optional

class UnidadFactorEmision(BaseModel):

    # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_UNIDAD_FACTOR_EMISION: int = Field(gt = 0)
    NOMBRE: str = Field(min_length=5, max_length=100)