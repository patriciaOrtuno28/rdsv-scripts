# Práctica Final RDSV

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

### Creación de la carpeta rdsv-final con los paquetes helm

Con este fichero se automatiza la creación de la carpeta rdsv-final para la ejecución de esta práctica.

```
chmod 777 folder/initFolder.sh
./folder/initFolder.sh
```

### Creación del servicio renes

Con este fichero se automatizan los apartados 3, 4, 5, 7 y 9 de la práctica 4.

Se crean los servicios `renes1` y `renes2`.

Se utiliza `source` para no perder las variables de entorno después de la ejecución del script.

```
chmod 777 renes/runRenes.sh
source ./renes/runRenes.sh
```

### Configuración del servicio renes

Con este fichero se automatiza la puesta en marcha de los servicios `renes1` y `renes2`, para dar conectividad a ambas redes residenciales.

```
chmod 777 renes/configRenes.sh
./renes/configRenes.sh
```
