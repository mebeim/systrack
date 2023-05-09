from typing import Union, Tuple, List, Optional

KernelVersion = Union[Tuple[int],Tuple[int,int],Tuple[int,int,int]]
EsotericSyscall = List[Tuple[int,str,str,Tuple[str,...],Optional[str]]]
