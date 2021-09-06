#!/usr/bin/python3.7

import json
import sys

def imprimir_propiedades(diccionario):
  for propiedad, valor in proyecto.items():
    print(propiedad + ": " + str(valor))

def ordenar(objeto):
  return objeto['id'].lower()


if len(sys.argv) != 2:
  print('uso ' + sys.argv[0] + ' <archivo_grupo_json>')
  exit(1)

nombre_archivo_proyectos = sys.argv[1]
archivo_proyectos = open(nombre_archivo_proyectos, 'r')
proyectos = json.loads(''.join(archivo_proyectos.readlines()))
archivo_proyectos.close()

lista = []
for proyecto in proyectos['projects']:
  lista.append({
    'id': proyecto['path'],
    'proyecto': proyecto
  })
lista.sort(key = ordenar)

for elemento in lista:
  proyecto = elemento['proyecto']
  print(proyecto['path'])
  print(proyecto['ssh_url_to_repo'])
  if 'default_branch' in proyecto:
    print(proyecto['default_branch'])
  else:
    print('main')
