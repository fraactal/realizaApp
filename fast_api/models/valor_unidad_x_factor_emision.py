'''CREATE TABLE VALOR_UNIDAD_X_FACTOR_EMISION(
ID_FACTOR_EMISION int,
ID_GAS_GEI int,
VALOR numeric(30,10),
PRIMARY KEY(ID_FACTOR_EMISION, ID_GAS_GEI),
    CONSTRAINT fk_valor_fe
      FOREIGN KEY(ID_FACTOR_EMISION) 
        REFERENCES FACTOR_DE_EMISION(ID_FACTOR_EMISION),
    CONSTRAINT fk_valor_gei
      FOREIGN KEY(ID_GAS_GEI) 
        REFERENCES TIPOS_GAS_GEI(ID_GAS_GEI)
);'''

from pydantic import BaseModel, Field
from typing import Optional

class ValorUnidad_x_FactorEmision(BaseModel):

    # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_FACTOR_EMISION: int = Field(gt = 0)
    ID_GAS_GEI: int = Field(gt = 0)
    VALOR: float = Field(gt = 0)