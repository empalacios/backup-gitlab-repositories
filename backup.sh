#!/bin/bash

groupid=
token=
directorio_actual=$(pwd)
archivo_proyectos=$directorio_actual/proyectos.txt
archivo_repositorios=$directorio_actual/repos.txt
directorio_repositorios=$directorio_actual/repositorios
directorio_repositorios_bare=$directorio_actual/repositorios_bare
directorio_repositorios_bare_comprimidos=$directorio_actual/repositorios_comprimidos
archivo_proyectos_pretty=$directorio_actual/proyectos_pretty.txt

echo 'Descargando informacion'
  curl https://gitlab.com/api/v4/groups/$groupid?private_token=$token > $archivo_proyectos 2>/dev/null
echo

echo 'Analizando informacion'
  python3 generar_listado_repositorios.py $archivo_proyectos > $archivo_repositorios
  python3 -m json.tool $archivo_proyectos > $archivo_proyectos_pretty
echo

echo 'Verificando directorios de salida'
  if [ ! -d "$directorio_repositorios" ]; then
    mkdir $directorio_repositorios
  fi
  rm -rf $directorio_repositorios_bare && mkdir $directorio_repositorios_bare
  rm -rf $directorio_repositorios_bare_comprimidos && mkdir $directorio_repositorios_bare_comprimidos
echo

echo 'Actualizando repositorios'
  cd $directorio_repositorios
  while read -r nombre_repo
  do
    read -r url_repo
    read -r default_branch
    if [ -d "$nombre_repo" ]; then
      echo "Actualizando el repositorio $nombre_repo"
      git -C $nombre_repo pull origin $default_branch
    else
      echo "Descargando el repositorio $nombre_repo"
      git clone $url_repo
    fi
    echo
  done < "$archivo_repositorios"
echo

echo 'Clonando proyectos bare'
  cd $directorio_repositorios_bare
  for proyecto in `ls $directorio_repositorios`; do
    git clone --bare $directorio_repositorios/$proyecto
  done;
echo

echo 'Comprimiendo proyectos bare'
  for proyecto in `ls $directorio_repositorios_bare`; do
    echo $proyecto
    cd $directorio_repositorios_bare/$proyecto
    tar -czvf $directorio_repositorios_bare/$proyecto.tar.gz * >/dev/null
  done;
  mv $directorio_repositorios_bare/*.tar.gz $directorio_repositorios_bare_comprimidos
echo

mv $archivo_proyectos $archivo_repositorios $archivo_proyectos_pretty $directorio_repositorios_bare
