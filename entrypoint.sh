#!/bin/bash
while :;
  do
  inotifywait -m /home/seluser/Downloads/ -e create 
  #@TODO= ejecutar deepspeech del fichero descargado, generar string en otra ruta, borrar fichero de nuevo

done
