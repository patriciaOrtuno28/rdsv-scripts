# Práctica Final RDSV

Clonar este repositorio en la carpeta ~/shared de la máquina K8s y OSM.

## Común

### Creación de la carpeta rdsv-final

Con este fichero se automatiza la creación de la carpeta rdsv-final para la ejecución de esta práctica.

```
chmod 777 folder/initFolder.sh
./folder/initFolder.sh
```

## K8S

### Arranque de las máquinas del escenario en K8s

Con este fichero se automatiza el arranque de las máquinas en K8s:

```
chmod 777 scenario/initScenario.sh
./scenario/initScenario.sh
```

Con este fichero se automatiza la destrucción de las máquinas en K8s:

```
chmod 777 scenario/stopScenario.sh
./scenario/stopScenario.sh
```

## OSM

### Creación del servicio renes

Con este fichero se automatizan los apartados 3, 4, 5, 7 y 9 de la práctica 4.

Se crean los servicios `renes1` y `renes2`.

Se utiliza `source` para no perder las variables de entorno después de la ejecución del script.

```
chmod 777 renes/createRenes.sh
source ./renes/createRenes.sh
```

### Inicio del servicio renes para dar conectividad a las redes residenciales

Con este fichero se automatiza la puesta en marcha de los servicios `renes1` y `renes2`, para dar conectividad a ambas redes residenciales.

```
chmod 777 renes/runRenes.sh
./renes/runRenes.sh
```

### (Opcional) Destruir los servicios renes y sus pods

```
chmod 777 renes/destroyRenes.sh
./renes/destroyRenes.sh
```
