# Práctica Final RDSV

### Arranque de las máquinas del escenario en K8s

```
chmod 777 initScenario.sh
./initScenario.sh
```

### Creación de la carpeta rdsv-final con los paquetes helm

Con este fichero se automatiza la creación de la carpeta rdsv-final para la ejecución de esta práctica.

```
chmod 777 initFolder.sh
./initFolder.sh
```

### Creación del servicio renes

Con este fichero se automatizan los apartados 3, 4, 5, 7 y 9 de la práctica 4.

Se crean los servicios `renes1` y `renes2`.

Se utiliza `source` para no perder las variables de entorno después de la ejecución del script.

```
chmod 777 runRenes.sh
source ./runRenes.sh
```

### Configuración del servicio renes

Con este fichero se automatiza la puesta en marcha de los servicios `renes1` y `renes2`, para dar conectividad a ambas redes residenciales.

```
chmod 777 configRenes.sh
./configRenes.sh
```
