@echo off
Set root=C:\Brilliantech\
Set mold=C:\Brilliantech\Mold\

If exist C:\Brilliantech\(

)Else(
  md "%root%"
)

If  exist "%mold%"(
 
)Else(
  md "%mold%"
)

copy * "%mold%"
 