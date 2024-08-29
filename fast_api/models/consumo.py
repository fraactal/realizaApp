from pydantic import BaseModel, Field
from typing import Optional

class Consumo(BaseModel):

  # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_CONSUMO: str = Field(min_length=5, max_length=50)
    ID_FUENTE: int = Field(gt=0)
    CANTIDAD_FUENTE: float = Field(default= 0, gt=0)
    LINK_RESPALDO: Optional [str] = None
    COMENTARIOS: Optional [str] = None
    HUELLACHILE : bool = Field(default = False)
    ID_CAMPUS: int = Field(gt = 0)
