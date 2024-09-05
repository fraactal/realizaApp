from pydantic import BaseModel, Field
from typing import Optional
from datetime import date, datetime

class Consumo(BaseModel):

  # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_CONSUMO: str = Field(min_length=5, max_length=50)
    ID_FUENTE: int = Field(gt=0)
    CANTIDAD_FUENTE: float = Field(dfault= 0, gt=0)
    FECHA: date = Field(default = datetime.now()) # DateTimePattern['%a, %d %b %Y %H:%M:%S %Z']
    LINK_RESPALDO: Optional [str] = None
    COMENTARIOS: Optional [str] = None
    HUELLACHILE : bool = Field(default = False)
    ID_CAMPUS: int = Field(gt = 0)
