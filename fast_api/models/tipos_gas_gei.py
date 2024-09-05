'''CREATE TABLE TIPOS_GAS_GEI(
ID_GAS_GEI int,
NOMBRE varchar(100) not null, -- dioxido de carbono
SIGLA varchar(15), -- CO2
PRIMARY KEY(ID_GAS_GEI)
);'''

from pydantic import BaseModel, Field
from typing import Optional

class TiposGasGei(BaseModel):

    # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_GAS_GEI: int = Field(gt = 0)
    NOMBRE: str = Field(min_length=5, max_length=100)
    SIGLA: str = Field(min_length=5, max_length=15)